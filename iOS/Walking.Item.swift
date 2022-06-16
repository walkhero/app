import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString
        let percent: Double
        
        init(value: AttributedString, limit: AttributedString, percent: Double) {
            self.value = value.numeric(font: .title2.monospacedDigit().weight(.regular), color: .primary)
            self.limit = limit
            self.percent = percent
        }
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(value)
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(limit)
                        .font(.footnote.monospacedDigit().weight(.light))
                        .foregroundStyle(.secondary)
                }
                ZStack {
                    Capsule()
                        .fill(.quaternary)
                    if percent > 0 {
                        Progress(value: min(percent, 1))
                            .stroke(Color.accentColor, style: .init(lineWidth: 3, lineCap: .round))
                    }
                }
                .frame(height: 2)
            }
            .padding(.leading, 2)
            .modifier(Card())
        }
    }
}
