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
            refresh()
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
        
        refresh()
    }

    func start(date: Date) async {
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
                                Task { [weak self] in
                                    await self?.add(steps: value)
                                }
                            }
                    }

                $0
                    .statisticsUpdateHandler = {  [weak self] _, _, results, _ in
                        _ = results
                            .map { value in
                                Task { [weak self] in
                                    await self?.add(steps: value)
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
                                Task { [weak self] in
                                    await self?.add(metres: value)
                                }
                            }
                    }

                $0
                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
                        _ = results
                            .map { value in
                                Task { [weak self] in
                                    await self?.add(metres: value)
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
                                Task { [weak self] in
                                    await self?.add(calories: value)
                                }
                            }
                    }

                $0
                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
                        _ = results
                            .map { value in
                                Task { [weak self] in
                                    await self?.add(calories: value)
                                }
                            }
                    }

                store.execute($0)
                queries.insert($0)
            }
    }

    func finish() async -> Summary? {
        let summary = await cloud.finish(steps: steps,
                                         metres: metres,
                                         calories: calories,
                                         squares: squares.items)

        await clear()

        return summary
    }

    func cancel() async {
        await cloud.cancel()
        await clear()
    }

    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        guard squares.add(locations: didUpdateLocations) else { return }
        refresh()
    }

    func locationManagerDidChangeAuthorization(_: CLLocationManager) { }
    func locationManager(_: CLLocationManager, didFailWithError: Error) { }

#if os(iOS)
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
    
    @MainActor private func update(overlay: MKPolygon) {
        self.overlay = overlay
    }
#endif
    
    @MainActor private func clear() {
        squares.clear()

        queries.forEach(store.stop)
        queries = []

        steps = 0
        metres = 0

#if os(iOS)
        manager.stopMonitoringSignificantLocationChanges()
#endif

        manager.stopUpdatingLocation()
    }
    
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
    
    private func refresh() {
        let total = squares.items.union(tiles)
        
        guard total.count != leaf.squares else { return }
        
        task?.cancel()
        
        explored = squares.items.subtracting(tiles).count
        leaf = .init(squares: total.count)
        
#if os(iOS)
        task = Task.detached(priority: .utility) { [weak self] in
            do {
                try await Task.sleep(nanoseconds: 3_000_000_000)
                
                guard !Task.isCancelled else { return }
                
                await self?.update(overlay: total.overlay)
            } catch { }
        }
#endif
    }

    private func query(start: Date, quantity: HKQuantityType) -> HKStatisticsCollectionQuery {
        .init(
            quantityType: quantity,
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
            options: .cumulativeSum,
            anchorDate: start,
            intervalComponents: .init(second: 10))
    }
}
