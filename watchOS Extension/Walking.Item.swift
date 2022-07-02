import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let indicator: Indicator
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                indicator
                    .frame(width: 60)
                    .padding(.top, 12)
                
                Text(value
                    .numeric(font: .system(size: 28, weight: .medium).monospacedDigit(),
                             color: .primary))
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            
            if let limit = limit {
                Text(limit.numeric(font: .system(size: 14, weight: .regular).monospacedDigit(),
                                   color: .secondary))
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
                    .padding(.bottom, 15)
            }
        }
    }
}
