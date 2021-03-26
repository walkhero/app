import Foundation
import HealthKit
import Combine
import Hero

final class Health {
    let steps = PassthroughSubject<Int, Never>()
    private var subs = Set<AnyCancellable>()
    private var queries = Set<HKQuery>()
    private let store = HKHealthStore()
    
    var available: Bool {
        HKHealthStore.isHealthDataAvailable()
    }
    
    func clear() {
        guard available else { return }
        queries.forEach(store.stop)
        queries = []
    }
    
    func steps(_ archive: Archive) {
        guard
            available == true,
            archive.enrolled(.steps),
            let start = archive.last?.start
        else { return }
        
        request(.steps) { [weak self] in
            self?.steps(start: start)
        }
    }
    
    func request(_ challenge: Challenge, completion: @escaping () -> Void) {
        guard let object = challenge.object else {
            return completion()
        }
        store.requestAuthorization(toShare: [], read: [object]) { _, _ in
            completion()
        }
    }
    
    private func steps(start: Date) {
        let query = HKStatisticsCollectionQuery(
            quantityType: Challenge.steps.quantity!,
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
            options: .cumulativeSum,
            anchorDate: start,
            intervalComponents: .init(minute: 1))
        
        query.initialResultsHandler = { [weak self] _, results, error in
            results.map {
                self?.steps(results: $0)
            }
        }
        
        query.statisticsUpdateHandler = { [weak self] _, _, results, _ in
            results.map {
                self?.steps(results: $0)
            }
        }
        
        store.execute(query)
        queries.insert(query)
    }
    
    private func steps(results: HKStatisticsCollection) {
        steps.send(results.statistics()
                    .compactMap {
                        $0.sumQuantity()
                            .map {
                                $0.doubleValue(for: .count())
                            }
                            .map(Int.init)
                    }
                    .reduce(0, +))
    }
}

private extension Challenge {
    var object: HKObjectType? {
        identifier.map {
            .quantityType(forIdentifier: $0)!
        }
    }
    
    var quantity: HKQuantityType? {
        identifier.flatMap {
            .quantityType(forIdentifier: $0)
        }
    }
    
    private var identifier: HKQuantityTypeIdentifier? {
        switch self {
        case .steps: return .stepCount
        default: return nil
        }
    }
}
