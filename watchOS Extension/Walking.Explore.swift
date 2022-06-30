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
                    .frame(width: 80)
                    .padding(.top, 13)
                
                Text(.squares(value: walker.explored)
                    .numeric(font: .title.monospacedDigit().weight(.medium),
                             color: .primary))
                .font(.callout.weight(.regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            
            if limit && walker.leaf.squares > 0 {
                Text((.plain(value: walker.leaf.squares)
                    + .init(" of ")
                      + .plain(value: walker.leaf.next))
                    .numeric(font: .body.monospacedDigit().weight(.regular),
                             color: .secondary))
                    .font(.callout.weight(.regular))
                    .lineLimit(1)
                    .foregroundStyle(.tertiary)
                    .padding(.bottom, 15)
            }
        }
    }
}
