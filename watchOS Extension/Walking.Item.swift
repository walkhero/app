import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let indicator: Indicator
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                indicator
                    .frame(width: 80)
                    .padding(.top, 13)
                
                Text(value
                    .numeric(font: .title.monospacedDigit().weight(.medium),
                             color: .primary))
                .font(.callout.weight(.regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            
            if let limit = limit {
                Text(limit.numeric(font: .body.monospacedDigit().weight(.regular),
                                   color: .secondary))
                    .font(.callout.weight(.regular))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
                    .padding(.bottom, 15)
            }
        }
    }
}
