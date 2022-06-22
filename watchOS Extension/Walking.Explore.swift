import SwiftUI

extension Walking {
    struct Explore: View {
        @ObservedObject var walker: Walker
        let limit: Bool
        
        var body: some View {
            Text(.squares(value: walker.explored)
                .numeric(font: .title2.monospacedDigit().weight(.medium),
                         color: .primary))
                .font(.footnote.weight(.regular))
                .lineLimit(1)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .modifier(Indicator(current: walker.leaf.squares, max: walker.leaf.next))
            
            if limit && walker.leaf.squares > 0 {
                Text(walker.leaf.squares.formatted() + " of " + walker.leaf.next.formatted())
                    .font(.footnote.weight(.regular))
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
        }
    }
}
