import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let progress: Progress
        
        init(value: AttributedString, limit: AttributedString?, progress: Progress) {
            self.value = value.numeric(font: .title2.monospacedDigit().weight(.regular),
                                       color: .primary)
            self.limit = limit
            self.progress = progress
        }
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(value)
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                    Spacer()
                    if let limit = limit {
                        Text(limit)
                            .font(.footnote.monospacedDigit().weight(.light))
                            .foregroundStyle(.secondary)
                    }
                }
                ZStack {
                    Capsule()
                        .fill(.quaternary)
                    progress
                        .stroke(Color.accentColor, style: .init(lineWidth: 3, lineCap: .round))
                }
                .frame(height: 2)
            }
            .padding(.leading, 2)
            .modifier(Card())
        }
    }
}
