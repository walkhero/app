import SwiftUI
import Hero

extension Chart.Trend {
    var symbol: some View {
        switch self {
        case .increase:
            return Image(systemName: "chevron.up")
                .font(.system(size: 16, weight: .heavy))
                .foregroundColor(.blue)
        case .decrease:
            return Image(systemName: "chevron.down")
                .font(.system(size: 16, weight: .heavy))
                .foregroundColor(.pink)
        case .stable:
            return Image(systemName: "alternatingcurrent")
                .font(.system(size: 16, weight: .heavy))
                .foregroundColor(.indigo)
        }
    }
}
