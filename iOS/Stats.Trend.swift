import SwiftUI
import Hero

extension Stats {
    struct Trend: View {
        let trend: Chart.Trend
        let text: Text
        
        var body: some View {
            HStack {
                Text("Average")
                    .foregroundColor(.secondary)
                    .font(.callout)
                Spacer()
                symbol
                text
                    .font(.body.weight(.light).monospacedDigit())
            }
        }
        
        private var symbol: some View {
            switch trend {
            case .increase:
                return Image(systemName: "chevron.up")
                    .font(.body.weight(.medium))
                    .foregroundColor(.blue)
            case .decrease:
                return Image(systemName: "chevron.down")
                    .font(.body.weight(.medium))
                    .foregroundColor(.pink)
            case .stable:
                return Image(systemName: "minus")
                    .font(.body.weight(.medium))
                    .foregroundColor(.primary)
            }
        }
    }
}
