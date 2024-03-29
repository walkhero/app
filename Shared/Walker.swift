import CoreLocation
import HealthKit
import Hero

#if os(iOS)
import UserNotifications
import MapKit
#endif

final class Walker: NSObject, ObservableObject, CLLocationManagerDelegate {
#if os(iOS)
    @Published private(set) var overlay = MKPolygon()
#endif
    
    @Published private(set) var steps = 0
    @Published private(set) var metres = 0
    @Published private(set) var calories = 0
    @Published private(set) var explored = 0
    @Published private(set) var leaf = Leaf(squares: 0)
    
    var tiles = Set<Squares.Item>() {
        didSet {
            Task {
                await refresh()
            }
        }
    }
    
    private var squares = Squares()
    private var queries = Set<HKQuery>()
    private var task: Task<Void, Never>?
    private let manager = CLLocationManager()
    private let store = HKHealthStore()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.allowsBackgroundLocationUpdates = true
        
        Task {
            await refresh()
        }
    }

    @MainActor func start(date: Date) async {
        manager.startUpdatingLocation()

#if os(iOS)
        manager.showsBackgroundLocationIndicator = true
        manager.startMonitoringSignificantLocationChanges()
#endif

        guard HKHealthStore.isHealthDataAvailable() else { return }

        Challenge
            .steps
            .quantity
            .map {
                query(start: date, quantity: $0)
            }
            .map {
                $0
                    .initialResultsHandler = { [weak self] _, results, _ in
                        _ = results
                            .map { value in
                                DispatchQueue.main.async { [weak self] in
                                    self?.add(steps: value)
                                }
                            }
                    }

                $0
                    .statisticsUpdateHandler = {  [weak self] _, _, results, _ in
                        _ = results
                            .map { value in
                                DispatchQueue.main.async { [weak self] in
                                    self?.add(steps: value)
                                }
                            }
                    }

                store.execute($0)
                queries.insert($0)
            }

        Challenge
            .metres
            .quantity
            .map {
                query(start: date, quantity: $0)
            }
            .map {
                $0
                    .initialResultsHandler = { [weak self] _, results, _ in
                        _ = results
                            .map { value in
                                DispatchQueue.main.async { [weak self] in
                                    self?.add(metres: value)
                                }
                            }
                    }

                $0
                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
                        _ = results
                            .map { value in
                                DispatchQueue.main.async { [weak self] in
                                    self?.add(metres: value)
                                }
                            }
                    }

                store.execute($0)
                queries.insert($0)
            }

        Challenge
            .calories
            .quantity
            .map {
                query(start: date, quantity: $0)
            }
            .map {
                $0
                    .initialResultsHandler = { [weak self] _, results, _ in
                        _ = results
                            .map { value in
                                DispatchQueue.main.async { [weak self] in
                                    self?.add(calories: value)
                                }
                            }
                    }

                $0
                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
                        _ = results
                            .map { value in
                                DispatchQueue.main.async { [weak self] in
                                    self?.add(calories: value)
                                }
                            }
                    }

                store.execute($0)
                queries.insert($0)
            }
    }

    @MainActor func finish(walking: UInt32, chart: Chart) async -> Summary? {
        guard walking != 0 else { return nil }
        
        let duration = Calendar.global.duration(from: walking)
        let steps = steps
        let metres = metres
        let calories = calories
        let items = await squares.items
        let current = Leaf(squares: items.union(tiles).count)
        var total = chart.walks
        
        if duration > 0 {
            total += 1
        }
        
        Task.detached {
            await cloud
                .finish(
                    duration: duration,
                    steps: steps,
                    metres: metres,
                    calories: calories,
                    squares: items)
        }

        return .init(leaf: leaf.name == current.name ? nil : current,
                     duration: .init(duration),
                     walks: total,
                     steps: steps,
                     metres: metres,
                     calories: calories,
                     squares: explored,
                     streak: chart.streak.current)
    }

    @MainActor func cancel() async {
        await cloud.cancel()
    }
    
    @MainActor func clear() async {
        await squares.clear()

        queries.forEach(store.stop)
        queries = []

        steps = 0
        metres = 0

#if os(iOS)
        manager.stopMonitoringSignificantLocationChanges()
#endif

        manager.stopUpdatingLocation()
    }

    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        Task {
            guard await squares.add(locations: didUpdateLocations) else { return }
            await refresh()
        }
    }

    func locationManagerDidChangeAuthorization(_: CLLocationManager) { }
    func locationManager(_: CLLocationManager, didFailWithError: Error) { }

#if os(iOS)
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
    
    @MainActor private func update(overlay: MKPolygon) {
        self.overlay = overlay
    }
#endif
    
    @MainActor private func add(steps: HKStatisticsCollection) {
        self.steps = steps
            .statistics()
            .compactMap {
                $0.sumQuantity()
                    .map {
                        $0.doubleValue(for: .count())
                    }
                    .map(Int.init)
            }
            .reduce(0, +)
    }

    @MainActor private func add(metres: HKStatisticsCollection) {
        self.metres = metres
            .statistics()
            .compactMap {
                $0.sumQuantity()
                    .map {
                        $0.doubleValue(for: .meter())
                    }
                    .map(Int.init)
            }
            .reduce(0, +)
    }

    @MainActor private func add(calories: HKStatisticsCollection) {
        self.calories = calories
            .statistics()
            .compactMap {
                $0.sumQuantity()
                    .map {
                        $0.doubleValue(for: .smallCalorie())
                    }
                    .map(Int.init)
            }
            .reduce(0, +)
    }
    
    @MainActor private func refresh() async {
        let total = await squares.items.union(tiles)
        
        guard total.count != leaf.squares else { return }
        
        task?.cancel()
        
        explored = await squares.items.subtracting(tiles).count
        leaf = .init(squares: total.count)
        
#if os(iOS)
        task = Task.detached(priority: .utility) { [weak self] in
            do {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                
                guard !Task.isCancelled else { return }
                
                await self?.update(overlay: total.overlay)
            } catch { }
        }
#endif
    }

    @MainActor private func query(start: Date, quantity: HKQuantityType) -> HKStatisticsCollectionQuery {
        .init(
            quantityType: quantity,
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
            options: .cumulativeSum,
            anchorDate: start,
            intervalComponents: .init(second: 10))
    }
}
