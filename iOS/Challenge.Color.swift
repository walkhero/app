import SwiftUI
import Hero

extension Challenge {
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
}
