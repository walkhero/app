import HealthKit

enum Challenge {
    case
    streak,
    steps,
    metres,
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
        case .metres: return .distanceWalkingRunning
        case .calories: return .activeEnergyBurned
        default: return nil
        }
    }
}
