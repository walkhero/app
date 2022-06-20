import SwiftUI
import Hero

extension Stats {
    struct Explore: View {
        let leaf: Leaf
        
        var body: some View {
            VStack(spacing: 5) {
                HStack {
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 50, weight: .ultraLight))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, leaf.name.color)
                    Text(leaf.name.title)
                        .font(.body.weight(.medium))
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                }
                .padding(.bottom, 5)
                
                if leaf.squares > 0 {
                    Text(.squares(value: leaf.squares)
                        .numeric(font: .title3.monospacedDigit().weight(.regular),
                                 color: .primary))
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                }
                
                Text(leaf.next.formatted() + " next")
                    .font(.caption2.monospacedDigit().weight(.light))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                
                Divider()
                    .padding(.top, 5)
            }
        }
    }
}
