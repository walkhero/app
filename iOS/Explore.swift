import SwiftUI
import Hero

struct Explore: View {
    let explored: Int
    let leaf: Leaf
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 0) {
                Text(.squares(value: explored)
                    .numeric(font: .largeTitle.monospacedDigit().weight(.regular),
                             color: .primary))
                    .font(.footnote.weight(.regular))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                Leafer(leaf: leaf)
            }
            HStack(alignment: .firstTextBaseline) {
                Text(leaf.squares, format: .number)
                    .font(.callout.monospacedDigit().weight(.regular))
                    .foregroundColor(.secondary)
                + Text(" total")
                    .font(.footnote.weight(.regular))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(leaf.next.formatted() + " next")
                    .font(.footnote.monospacedDigit().weight(.light))
                    .foregroundStyle(.secondary)
            }
            ZStack {
                Capsule()
                    .fill(.quaternary)
                Progress(value: .init(leaf.squares) / .init(leaf.next))
                    .stroke(Color.accentColor, style: .init(lineWidth: 3, lineCap: .round))
            }
            .frame(height: 2)
        }
        .modifier(Card())
    }
}
