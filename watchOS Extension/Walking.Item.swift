import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let indicator: Indicator
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                indicator
                    .frame(width: 90)
                    .padding(.top, 8)
                
                Text(value
                    .numeric(font: .system(size: 30, weight: .medium).monospacedDigit(),
                             color: .primary))
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            
            if let limit = limit {
                Text(limit.numeric(font: .system(size: 17, weight: .regular).monospacedDigit(),
                                   color: .secondary))
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
                    .padding(.bottom, 15)
            }
        }
    }
}
