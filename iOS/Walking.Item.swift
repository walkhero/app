import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let progress: Progress
        
        init(value: AttributedString, limit: AttributedString?, progress: Progress) {
            self.value = value.numeric(font: .title.monospacedDigit().weight(.medium),
                                       color: .primary)
            self.limit = limit
            self.progress = progress
        }
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(value)
                        .font(.callout.weight(.regular))
                        .foregroundColor(.secondary)
                    Spacer()
                    if let limit = limit {
                        Text(limit)
                            .font(.footnote.monospacedDigit().weight(.regular))
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
