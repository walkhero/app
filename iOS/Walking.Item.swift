import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: Text
        let percent: Double
        
        init(value: AttributedString, limit: Text, percent: Double) {
            var value = value
            value.runs.forEach { run in
                if run.numberPart != nil || run.numberSymbol != nil {
                    value[run.range].foregroundColor = .primary
                    value[run.range].font = .title2.monospacedDigit().weight(.regular)
                } else {
                    value[run.range].foregroundColor = .secondary
                    value[run.range].font = .footnote.weight(.regular)
                }
            }
            self.value = value
            self.limit = limit
            self.percent = percent
        }
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(value)
                    Spacer()
                    limit
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
