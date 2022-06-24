import SwiftUI

extension Walking {
    struct Explore: View {
        @ObservedObject var walker: Walker
        let limit: Bool
        
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                Text(.squares(value: walker.explored)
                    .numeric(font: .title3.monospacedDigit().weight(.medium),
                             color: .primary))
                    .font(.footnote.weight(.regular))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .fixedSize()
                
                Indicator(current: walker.leaf.current, max: walker.leaf.total)
            }
            .padding(.top, 2)
            
            if limit && walker.leaf.squares > 0 {
                Text((.plain(value: walker.leaf.squares)
                    + .init(" of ")
                      + .plain(value: walker.leaf.next))
                    .numeric(font: .footnote.monospacedDigit().weight(.regular),
                             color: .secondary))
                    .font(.footnote.weight(.regular))
                    .lineLimit(1)
                    .foregroundStyle(.tertiary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
        }
    }
}
