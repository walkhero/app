import SwiftUI

extension Walking {
    struct Explore: View {
        @ObservedObject var walker: Walker
        let limit: Bool
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                Indicator(current: walker.leaf.current,
                          max: walker.leaf.total,
                          height: 6)
                    .frame(width: 60)
                    .padding(.top, 12)
                
                Text(.squares(value: walker.explored)
                    .numeric(font: .system(size: 28, weight: .medium).monospacedDigit(),
                             color: .primary))
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            
            if limit && walker.leaf.squares > 0 {
                Text((.plain(value: walker.leaf.squares)
                      + .init(" of ")
                      + .plain(value: walker.leaf.next))
                    .numeric(font: .system(size: 16, weight: .regular).monospacedDigit(),
                             color: .secondary))
                .font(.system(size: 14, weight: .regular))
                .lineLimit(1)
                .foregroundStyle(.tertiary)
                .padding(.bottom, 15)
            }
        }
    }
}
