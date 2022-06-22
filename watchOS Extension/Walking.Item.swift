import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let indicator: Indicator
        
        var body: some View {
            Text(value
                .numeric(font: .title2.monospacedDigit().weight(.medium),
                         color: .primary))
            .font(.footnote.weight(.regular))
            .lineLimit(1)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            .modifier(indicator)
            
            if let limit = limit {
                Text(limit)
                    .font(.footnote.monospacedDigit().weight(.regular))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
        }
    }
}
