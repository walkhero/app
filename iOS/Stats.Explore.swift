import SwiftUI
import Hero

extension Stats {
    struct Explore: View {
        let leaf: Leaf
        @State private var badges = false
        
        var body: some View {
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 60, weight: .ultraLight))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, leaf.name.color)
                    VStack(alignment: .leading) {
                        Text(leaf.name.title)
                            .font(.callout.weight(.medium))
                        Text(leaf.next.formatted() + " next")
                            .font(.footnote.monospacedDigit().weight(.light))
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    
                    Button("Badges") {
                        badges = true
                    }
                    .font(.footnote.weight(.medium))
                    .foregroundColor(.primary)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                }
                
                if leaf.squares > 0 {
                    Text(.squares(value: leaf.squares)
                        .numeric(font: .title.monospacedDigit().weight(.regular),
                                 color: .primary))
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                }
            }
            .modifier(Card())
            .sheet(isPresented: $badges) {
                Sheet(rootView: Badges(leaf: leaf))
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
