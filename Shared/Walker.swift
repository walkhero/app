import CoreLocation
import HealthKit
import Hero

#if os(iOS)
import UserNotifications
#endif

final class Walker: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var squares = Squares()
    @Published private(set) var steps = 0
    @Published private(set) var metres = 0
    @Published private(set) var calories = 0
    private var queries = Set<HKQuery>()
    private let manager = CLLocationManager()
    private let store = HKHealthStore()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.allowsBackgroundLocationUpdates = true
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

    @MainActor func clear() {
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

    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        squares.add(locations: didUpdateLocations)
    }

    func locationManagerDidChangeAuthorization(_: CLLocationManager) { }
    func locationManager(_: CLLocationManager, didFailWithError: Error) { }

    #if os(iOS)
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
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

    private func query(start: Date, quantity: HKQuantityType) -> HKStatisticsCollectionQuery {
        .init(
            quantityType: quantity,
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
            options: .cumulativeSum,
            anchorDate: start,
            intervalComponents: .init(second: 10))
    }
}


