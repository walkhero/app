import SwiftUI

extension Walking {
    struct Explore: View {
        @ObservedObject var walker: Walker
        
        var body: some View {
            VStack {
                Text(.squares(value: walker.explored)
                    .numeric(font: .title3.monospacedDigit().weight(.medium),
                             color: .primary))
                    .font(.footnote.weight(.regular))
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                if walker.leaf.squares > 0 {
                    Text(walker.leaf.squares.formatted() + " of " + walker.leaf.next.formatted())
                        .font(.footnote.weight(.regular))
                        .lineLimit(1)
                        .foregroundStyle(.tertiary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                }
                Indicator(current: walker.leaf.squares, max: walker.leaf.next)
            }
            .modifier(Card())
        }
    }
}
