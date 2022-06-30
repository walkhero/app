import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let indicator: Indicator
        
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                Text(value
                    .numeric(font: .title.monospacedDigit().weight(.medium),
                             color: .primary))
                .font(.callout.weight(.regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .fixedSize()
                
                indicator
            }
            
            if let limit = limit {
                Text(limit.numeric(font: .body.monospacedDigit().weight(.regular),
                                   color: .secondary))
                    .font(.callout.weight(.regular))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom, 15)
            }
        }
    }
}
