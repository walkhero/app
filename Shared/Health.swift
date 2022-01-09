import Foundation
import HealthKit

final class Health: ObservableObject {
    @Published private(set) var steps = 0
    @Published private(set) var distance = 0
    private(set) var started = false
    private var queries = Set<HKQuery>()
    private let store = HKHealthStore()
    
    func clear() {
        queries.forEach(store.stop)
        queries = []
        steps = 0
        distance = 0
        started = false
    }
    
    func request() async {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        try? await store
            .requestAuthorization(toShare: [],
                                  read: .init([Challenge.steps, .distance].compactMap(\.object)))
    }
    
    func start(date: Date) {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        clear()
        started = true
        
        Challenge
            .steps
            .quantity
            .map {
                query(start: date, quantity: $0)
            }
            .map {
                $0
                    .initialResultsHandler = { [weak self] _, results, _ in
                        results
                            .map {
                                self?.add(steps: $0)
                            }
                    }
                
                $0
                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
                        results
                            .map {
                                self?.add(steps: $0)
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
                    .initialResultsHandler = { [weak self] _, results, _ in
                        results
                            .map {
                                self?.add(distance: $0)
                            }
                    }
                
                $0
                    .statisticsUpdateHandler = { [weak self] _, _, results, _ in
                        results
                            .map {
                                self?.add(distance: $0)
                            }
                    }
                
                store.execute($0)
                queries.insert($0)
            }
    }
    
    private func query(start: Date, quantity: HKQuantityType) -> HKStatisticsCollectionQuery {
        .init(
            quantityType: quantity,
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
            options: .cumulativeSum,
            anchorDate: start,
            intervalComponents: .init(minute: 1))
    }
    
    private func add(steps: HKStatisticsCollection) {
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
    
    private func add(distance: HKStatisticsCollection) {
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
