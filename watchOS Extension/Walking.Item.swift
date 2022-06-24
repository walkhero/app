import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let indicator: Indicator
        
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                Text(value
                    .numeric(font: .title3.monospacedDigit().weight(.medium),
                             color: .primary))
                .font(.footnote.weight(.regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .fixedSize()
                
                indicator
            }
            .padding(.top, 6)
            
            if let limit = limit {
                Text(limit.numeric(font: .footnote.monospacedDigit().weight(.regular),
                                   color: .secondary))
                    .font(.footnote.weight(.regular))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom, 10)
            }
        }
    }
}
