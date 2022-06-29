import SwiftUI
import Hero

struct Achievement: View {
    @ObservedObject var session: Session
    let leaf: Leaf
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("NEW ACHIEVEMENT")
                .font(.body.weight(.bold))
                .foregroundColor(.white)
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(Color.accentColor)
                .clipShape(Capsule())
            
            Spacer()
            
            VStack {
                Image(systemName: "leaf.circle.fill")
                    .font(.system(size: 100, weight: .ultraLight))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.black, leaf.name.color)
                Text(leaf.name.title)
                    .font(.title.weight(.medium))
                Text(leaf.value, format: .number)
                    .font(.title3.monospacedDigit().weight(.light))
                Text("Squares")
                    .font(.title3.weight(.light))
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 25)
            .modifier(Card())
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 0.6)) {
                    session.achievement = nil
                }
            } label: {
                Text("Continue")
                    .font(.callout.weight(.bold))
                    .padding(.vertical, 5)
                    .frame(minWidth: 240)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}
