import SwiftUI
import Hero

extension Stats {
    struct Explore: View {
        let leaf: Leaf
        
        var body: some View {
            Image(systemName: "leaf.circle.fill")
                .font(.system(size: 50, weight: .ultraLight))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.black, leaf.name.color)
            
            Text(leaf.name.title)
                .font(.title2.weight(.medium))
                .lineLimit(1)
                .padding(.horizontal)
            
            if leaf.squares > 0 {
                Text(.squares(value: leaf.squares)
                    .numeric(font: .title3.monospacedDigit().weight(.regular),
                             color: .primary))
                .font(.footnote.weight(.regular))
                .lineLimit(1)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            }
            
            Text(leaf.next.formatted() + " next")
                .font(.caption2.monospacedDigit().weight(.light))
                .lineLimit(1)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
        }
    }
}
