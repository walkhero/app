import SwiftUI
import Hero

extension Chart.Trend {
    var symbol: String {
        switch self {
        case .increase:
            return "chevron.up"
        case .decrease:
            return "chevron.down"
        case .stable:
            return "alternatingcurrent"
        }
    }
}
