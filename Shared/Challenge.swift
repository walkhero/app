import HealthKit

enum Challenge: String {
    case
    streak,
    steps,
    distance,
    map,
    calories
}

extension Challenge {
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
        case .calories: return .activeEnergyBurned
        default: return nil
        }
    }
}
