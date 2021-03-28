import Foundation
import HealthKit
import Combine
import Hero

final class Health {
    let steps = PassthroughSubject<Int, Never>()
    let distance = PassthroughSubject<Int, Never>()
    private var subs = Set<AnyCancellable>()
    private var queries = Set<HKQuery>()
    private let store = HKHealthStore()
    
    func clear() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        queries.forEach(store.stop)
        queries = []
    }
    
    func request(_ challenge: Challenge, completion: @escaping () -> Void) {
        guard let object = challenge.object else {
            return completion()
        }
        store.requestAuthorization(toShare: [], read: [object]) { _, _ in
            completion()
        }
    }
    
    func steps(_ archive: Archive) {
        start(archive, .steps) { [weak self] in
            self?.steps.send($0.statistics()
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
    
    func distance(_ archive: Archive) {
        start(archive, .distance) { [weak self] in
            self?.distance.send($0.statistics()
                                    .compactMap {
                                        $0.sumQuantity()
                                            .map {
                                                $0.doubleValue(for: .meter())
                                            }
                                            .map(Int.init)
                                    }
                                    .reduce(0, +))
        }
    }
    
    private func start(_ archive: Archive, _ challenge: Challenge, completion: @escaping (HKStatisticsCollection) -> Void) {
        guard
            HKHealthStore.isHealthDataAvailable(),
            archive.enrolled(challenge),
            let start = archive.last?.start,
            let quantity = challenge.quantity
        else { return }
        
        request(challenge) { [weak self] in
            let query = HKStatisticsCollectionQuery(
                quantityType: quantity,
                quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
                options: .cumulativeSum,
                anchorDate: start,
                intervalComponents: .init(minute: 1))
            
            query.initialResultsHandler = { _, results, _ in
                results.map(completion)
            }
            
            query.statisticsUpdateHandler = { _, _, results, _ in
                results.map(completion)
            }
            
            self?.store.execute(query)
            self?.queries.insert(query)
        }
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
        case .distance: return .distanceWalkingRunning
        default: return nil
        }
    }
}
