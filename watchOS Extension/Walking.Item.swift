import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let indicator: Indicator
        
        var body: some View {
            VStack {
                Text(value
                    .numeric(font: .title3.monospacedDigit().weight(.medium),
                             color: .primary))
                .font(.footnote.weight(.regular))
                .lineLimit(1)
                .foregroundColor(.secondary)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                
                if let limit = limit {
                    Text(limit)
                        .font(.footnote.monospacedDigit().weight(.regular))
                        .foregroundStyle(.tertiary)
                        .lineLimit(1)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                }
                
                indicator
            }
            .modifier(Card())
        }
    }
}
