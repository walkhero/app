import SwiftUI
import Hero

extension Challenge {
    var title: String {
        switch self {
        case .streak:
            return "Streak\nChallenge"
        case .steps:
            return "Steps\nChallenge"
        case .distance:
            return "Distance\nChallenge"
        case .map:
            return "Map\nChallenge"
        }
    }
    
    var subtitle: String {
        switch self {
        case .streak:
            return "Walk every day"
        case .steps:
            return "Count your steps"
        case .distance:
            return "Go longer distances"
        case .map:
            return "Discover your surroundings"
        }
    }
    
    var symbol: String {
        switch self {
        case .streak:
            return "calendar"
        case .steps:
            return "speedometer"
        case .distance:
            return "point.topleft.down.curvedto.point.bottomright.up"
        case .map:
            return "map.fill"
        }
    }
    
    var background: LinearGradient {
        switch self {
        case .streak:
            return .init(gradient: .init(colors: [.blue, .init(.systemIndigo)]),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
        case .steps:
            return .init(gradient: .init(colors: [.orange, .pink]),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
        case .distance:
            return .init(gradient: .init(colors: [.green, .init(.systemTeal)]),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
        case .map:
            return .init(gradient: .init(colors: [.init(.systemIndigo), .purple]),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
        }
    }
    
    var leaderboard: String {
        "\(self)"
    }
}
