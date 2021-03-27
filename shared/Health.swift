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
    
    func steps(_ archive: Archive) {
        start(archive, .steps) { [weak self] in
            self?.steps(start: $0)
        }
    }
    
    func distance(_ archive: Archive) {
        start(archive, .distance) { [weak self] in
            self?.distance(start: $0)
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
    
    private func start(_ archive: Archive, _ challenge: Challenge, completion: @escaping (Date) -> Void) {
        guard
            HKHealthStore.isHealthDataAvailable(),
            archive.enrolled(challenge),
            let start = archive.last?.start
        else { return }
        
        request(challenge) { [weak self] in
            completion(start)
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
    
    private func distance(start: Date) {
        let query = HKStatisticsCollectionQuery(
            quantityType: Challenge.distance.quantity!,
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: start, end: nil),
            options: .cumulativeSum,
            anchorDate: start,
            intervalComponents: .init(minute: 1))
        
        query.initialResultsHandler = { [weak self] _, results, error in
            results.map {
                self?.distance(results: $0)
            }
        }
        
        query.statisticsUpdateHandler = { [weak self] _, _, results, _ in
            results.map {
                self?.distance(results: $0)
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
    
    private func distance(results: HKStatisticsCollection) {
        distance.send(results.statistics()
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
