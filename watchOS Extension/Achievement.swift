import SwiftUI
import Hero

struct Achievement: View {
    @ObservedObject var session: Session
    let leaf: Leaf
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("NEW\nACHIEVEMENT")
                    .font(.body.weight(.bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .padding(.vertical, 10)
                    .background(Color.accentColor.opacity(0.6))
                    .clipShape(Capsule())
                    .padding()
                
                VStack {
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 80, weight: .ultraLight))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, leaf.name.color)
                    Text(leaf.name.title)
                        .font(.title2.weight(.medium))
                    Text(leaf.value, format: .number)
                        .font(.body.monospacedDigit().weight(.light))
                    Text("Squares")
                        .font(.body.weight(.light))
                        .foregroundStyle(.secondary)
                }
                .fixedSize(horizontal: false, vertical: true)
                
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
                .padding()
                .padding(.bottom, 20)
            }
        }
    }
}
