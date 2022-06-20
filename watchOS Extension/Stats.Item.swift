import SwiftUI
import Hero

extension Stats {
    struct Item: View {
        let value: AttributedString
        let trend: Chart.Trend?
        
        var body: some View {
            VStack(spacing: 10) {
                HStack {
                    if let trend = trend {
                        trend.symbol
                    }
                    Text(value
                        .numeric(font: .title3.monospacedDigit().weight(.regular),
                                 color: .primary))
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                    Spacer()
                }
                Divider()
            }
        }
    }
}
