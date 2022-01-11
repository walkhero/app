import Foundation
import CoreLocation
import HealthKit
import GameKit
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
    
    func login() {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
#if os(iOS)
        GKLocalPlayer.local.authenticateHandler = { controller, _ in
            guard let controller = controller else { return }
            UIApplication.shared.present(controller: controller)
        }
#else
        GKLocalPlayer.local.authenticateHandler = { _ in

        }
#endif
    }
    
    func request() async {
        if CLLocationManager().authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        }
        
        _ = await UNUserNotificationCenter.request()
        
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
        started = false
        
        await cloud.finish(steps: steps,
                           metres: distance,
                           tiles: tiles)
        
        await UNUserNotificationCenter.send(message: "Walk finished!")
        
        let streak = await cloud.model.calendar.streak.current
        let map = await cloud.model.tiles.count
        
        submit(streak: streak, steps: steps, distance: distance, map: map)
        clear()
    }
    
    func cancel() async {
        await cloud.cancel()
        clear()
        await UNUserNotificationCenter.send(message: "Walk cancelled!")
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
    
    private func submit(streak: Int, steps: Int, distance: Int, map: Int) {
        GKLeaderboard.submitScore(
            streak,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.streak.leaderboard]) { _ in }
        
        GKLeaderboard.submitScore(
            steps,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.steps.leaderboard]) { _ in }
        
        GKLeaderboard.submitScore(
            distance,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.distance.leaderboard]) { _ in }
        
        GKLeaderboard.submitScore(
            map,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.map.leaderboard]) { _ in }
    }
}

private enum Challenge: String {
    case
    streak,
    steps,
    distance,
    map
    
    var leaderboard: String {
        "\(self)"
    }
    
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
