import Foundation
import CoreLocation
import HealthKit
import UserNotifications
import Hero

final class Status: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var froob = false
    @Published var tools = false
    @Published var hide = Defaults.shouldHide
    @Published var follow = Defaults.shouldFollow
    @Published private(set) var tiles = Set<Tile>()
    @Published private(set) var steps = 0
    @Published private(set) var distance = 0
    private(set) var started = false
    private var queries = Set<HKQuery>()
    private let manager = CLLocationManager()
    private let store = HKHealthStore()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.allowsBackgroundLocationUpdates = true
    }
    
    func request() async {
        if CLLocationManager().authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        }
        
#if os(iOS)
        _ = await UNUserNotificationCenter.request()
#endif
        
        guard HKHealthStore.isHealthDataAvailable() else { return }
        try? await store
            .requestAuthorization(toShare: [],
                                  read: .init([Challenge.steps, .distance].compactMap(\.object)))
    }
    
    func start(date: Date) {
        clear()
        
        started = true
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
                    .initialResultsHandler = { _, results, _ in
                        _ = results
                            .map { value in
                                Task { [weak self] in
                                    await self?.add(steps: value)
                                }
                            }
                    }
                
                $0
                    .statisticsUpdateHandler = { _, _, results, _ in
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
            .distance
            .quantity
            .map {
                query(start: date, quantity: $0)
            }
            .map {
                $0
                    .initialResultsHandler = { _, results, _ in
                        _ = results
                            .map { value in
                                Task { [weak self] in
                                    await self?.add(distance: value)
                                }
                            }
                    }
                
                $0
                    .statisticsUpdateHandler = { _, _, results, _ in
                        _ = results
                            .map { value in
                                Task { [weak self] in
                                    await self?.add(distance: value)
                                }
                            }
                    }
                
                store.execute($0)
                queries.insert($0)
            }
    }
    
    func finish() async {
        guard started else { return }
        
        await cloud.finish(steps: steps,
                           metres: distance,
                           tiles: tiles)
        
#if os(iOS)
        await UNUserNotificationCenter.send(message: "Walk finished!")
#endif
        clear()
    }
    
    func cancel() async {
        await cloud.cancel()
        clear()
        
#if os(iOS)
        await UNUserNotificationCenter.send(message: "Walk cancelled!")
#endif
    }
    
    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        _ = didUpdateLocations
            .last
            .map(\.coordinate)
            .map(Tile.init(coordinate:))
            .map {
                tiles.insert($0)
            }
    }
    
    func locationManager(_: CLLocationManager, didChangeAuthorization: CLAuthorizationStatus) { }
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
    
    @MainActor private func add(distance: HKStatisticsCollection) {
        self.distance = distance
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
    
    private func query(start: Date, quantity: HKQuantityType) -> HKStatisticsCollectionQuery {
        .init(
            quantityType: quantity,
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
            options: .cumulativeSum,
            anchorDate: start,
            intervalComponents: .init(minute: 1))
    }
    
    private func clear() {
        started = false
        tiles = []
        
        queries.forEach(store.stop)
        queries = []
        
        steps = 0
        distance = 0
        
        #if os(iOS)
        manager.stopMonitoringSignificantLocationChanges()
        #endif
        
        manager.stopUpdatingLocation()
    }
}

private extension Challenge {
    var object: HKObjectType? {
        identifier
            .map {
                .quantityType(forIdentifier: $0)!
            }
    }
    
    var quantity: HKQuantityType? {
        identifier
            .flatMap {
                .quantityType(forIdentifier: $0)
            }
    }
    
    private var identifier: HKQuantityTypeIdentifier? {
        switch self {
        case .steps: return .stepCount
        case .distance: return .distanceWalkingRunning
        default: return nil
        }
    }
}
