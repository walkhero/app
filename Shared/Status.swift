//import Foundation
//import CoreLocation
//import HealthKit
//import Hero
//
//#if os(iOS)
//import UserNotifications
//#endif
//
//final class Status: NSObject, ObservableObject, CLLocationManagerDelegate {
//
//#if os(iOS)
//    @Published var hide = Defaults.shouldHide
//    @Published var follow = true
//#endif
//    
//    @Published private(set) var squares = Squares()
//    @Published private(set) var steps = 0
//    @Published private(set) var distance = 0
//    @Published private(set) var calories = 0
//    private(set) var started = false
//    private var queries = Set<HKQuery>()
//    private let manager = CLLocationManager()
//    private let store = HKHealthStore()
//    
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//        manager.allowsBackgroundLocationUpdates = true
//    }
//    
//    func request() async {
//        if CLLocationManager().authorizationStatus == .notDetermined {
//            manager.requestAlwaysAuthorization()
//        }
//        
//#if os(iOS)
//        _ = await UNUserNotificationCenter.request()
//#endif
//        
//        guard HKHealthStore.isHealthDataAvailable() else { return }
//        try? await store
//            .requestAuthorization(toShare: [],
//                                  read: .init([Challenge.steps, .distance, .calories].compactMap(\.object)))
//    }
//    
//    func start(date: Date) async {
//        guard !started else { return }
//        
//        started = true
//        manager.startUpdatingLocation()
//        
//#if os(iOS)
//        manager.showsBackgroundLocationIndicator = true
//        manager.startMonitoringSignificantLocationChanges()
//#endif
//
//        guard HKHealthStore.isHealthDataAvailable() else { return }
//        
//        Challenge
//            .steps
//            .quantity
//            .map {
//                query(start: date, quantity: $0)
//            }
//            .map {
//                $0
//                    .initialResultsHandler = { [weak self] _, results, _ in
//                        _ = results
//                            .map { value in
//                                Task { [weak self] in
//                                    await self?.add(steps: value)
//                                }
//                            }
//                    }
//                
//                $0
//                    .statisticsUpdateHandler = {  [weak self] _, _, results, _ in
//                        _ = results
//                            .map { value in
//                                Task { [weak self] in
//                                    await self?.add(steps: value)
//                                }
//                            }
//                    }
//                
//                store.execute($0)
//                queries.insert($0)
//            }
//        
//        Challenge
//            .distance
//            .quantity
//            .map {
//                query(start: date, quantity: $0)
//            }
//            .map {
//                $0
//                    .initialResultsHandler = { [weak self] _, results, _ in
//                        _ = results
//                            .map { value in
//                                Task { [weak self] in
//                                    await self?.add(distance: value)
//                                }
//                            }
//                    }
//                
//                $0
//                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
//                        _ = results
//                            .map { value in
//                                Task { [weak self] in
//                                    await self?.add(distance: value)
//                                }
//                            }
//                    }
//                
//                store.execute($0)
//                queries.insert($0)
//            }
//        
//        Challenge
//            .calories
//            .quantity
//            .map {
//                query(start: date, quantity: $0)
//            }
//            .map {
//                $0
//                    .initialResultsHandler = { [weak self] _, results, _ in
//                        _ = results
//                            .map { value in
//                                Task { [weak self] in
//                                    await self?.add(calories: value)
//                                }
//                            }
//                    }
//                
//                $0
//                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
//                        _ = results
//                            .map { value in
//                                Task { [weak self] in
//                                    await self?.add(calories: value)
//                                }
//                            }
//                    }
//                
//                store.execute($0)
//                queries.insert($0)
//            }
//    }
//    
//    func finish() async -> Summary? {
//        guard started else { return nil }
//        started = false
//        
//        let summary = await cloud.finish(steps: steps,
//                                         metres: distance,
//                                         calories: calories,
//                                         squares: squares.items)
//        
//        await clear()
//        
//        return summary
//    }
//    
//    func cancel() async {
//        guard started else { return }
//        started = false
//        
//        await cloud.cancel()
//        await clear()
//    }
//    
//    @MainActor func clear() {
//        started = false
//        squares.clear()
//        
//        queries.forEach(store.stop)
//        queries = []
//        
//        steps = 0
//        distance = 0
//        
//#if os(iOS)
//        manager.stopMonitoringSignificantLocationChanges()
//#endif
//        
//        manager.stopUpdatingLocation()
//    }
//    
//    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
//        squares.add(locations: didUpdateLocations)
//    }
//    
//    func locationManagerDidChangeAuthorization(_: CLLocationManager) { }
//    func locationManager(_: CLLocationManager, didFailWithError: Error) { }
//    
//    #if os(iOS)
//    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
//    #endif
//    
//    @MainActor private func add(steps: HKStatisticsCollection) {
//        self.steps = steps
//            .statistics()
//            .compactMap {
//                $0.sumQuantity()
//                    .map {
//                        $0.doubleValue(for: .count())
//                    }
//                    .map(Int.init)
//            }
//            .reduce(0, +)
//    }
//    
//    @MainActor private func add(distance: HKStatisticsCollection) {
//        self.distance = distance
//            .statistics()
//            .compactMap {
//                $0.sumQuantity()
//                    .map {
//                        $0.doubleValue(for: .meter())
//                    }
//                    .map(Int.init)
//            }
//            .reduce(0, +)
//    }
//    
//    @MainActor private func add(calories: HKStatisticsCollection) {
//        self.calories = calories
//            .statistics()
//            .compactMap {
//                $0.sumQuantity()
//                    .map {
//                        $0.doubleValue(for: .smallCalorie())
//                    }
//                    .map(Int.init)
//            }
//            .reduce(0, +)
//    }
//    
//    private func query(start: Date, quantity: HKQuantityType) -> HKStatisticsCollectionQuery {
//        .init(
//            quantityType: quantity,
//            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
//            options: .cumulativeSum,
//            anchorDate: start,
//            intervalComponents: .init(second: 10))
//    }
//}
//
//private extension Challenge {
//    var object: HKObjectType? {
//        identifier
//            .map {
//                .quantityType(forIdentifier: $0)!
//            }
//    }
//    
//    var quantity: HKQuantityType? {
//        identifier
//            .flatMap {
//                .quantityType(forIdentifier: $0)
//            }
//    }
//    
//    private var identifier: HKQuantityTypeIdentifier? {
//        switch self {
//        case .steps: return .stepCount
//        case .distance: return .distanceWalkingRunning
//        case .calories: return .activeEnergyBurned
//        default: return nil
//        }
//    }
//}
