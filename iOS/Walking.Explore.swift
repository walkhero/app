import SwiftUI

extension Walking {
    struct Explore: View {
        @ObservedObject var walker: Walker
        @State private var map = false
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    Text(.squares(value: walker.explored)
                        .numeric(font: .largeTitle.monospacedDigit().weight(.medium),
                                 color: .primary))
                        .font(.callout.weight(.regular))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 30, weight: .ultraLight))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, walker.leaf.name.color)
                        .padding(.trailing, 10)
                    
                    Button {
                        map = true
                    } label: {
                        Image(systemName: "globe.europe.africa.fill")
                            .font(.system(size: 18, weight: .medium))
                            .padding(.horizontal, 6)
                            .contentShape(Rectangle())
                    }
                    .tint(.accentColor)
                    .foregroundColor(.white)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $map) {
                        Sheet(rootView: Mapper(walker: walker))
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    if walker.leaf.squares > 0 {
                        Text(walker.leaf.squares.formatted() + " total")
                            .font(.footnote.monospacedDigit().weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Text(walker.leaf.next.formatted() + " next")
                        .font(.footnote.monospacedDigit().weight(.regular))
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 10)
                ZStack {
                    Capsule()
                        .fill(.quaternary)
                    Progress(current: walker.leaf.squares, max: walker.leaf.next)
                        .stroke(Color.accentColor, style: .init(lineWidth: 3, lineCap: .round))
                }
                .frame(height: 2)
            }
            .modifier(Card())
        }
    }
}
