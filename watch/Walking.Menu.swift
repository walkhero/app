import SwiftUI
import Hero

extension Walking {
    struct Menu: View {
        @Binding var session: Session
        let streak: Int
        let steps: Int
        let metres: Int
        let tiles: Set<Tile>
        @State private var disabled = false
        
        var body: some View {
            VStack {
                Button {
                    clear()
                    session.watch.send(.init(streak: streak, steps: steps, distance: metres, map: tiles.count))
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.archive.end(steps: steps, metres: metres, tiles: tiles)
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .fill(LinearGradient(
                                    gradient: .init(colors: [.purple, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing))
                        Text("FINISH")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                    }
                    .fixedSize()
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(disabled)
                Spacer()
                Image(systemName: "figure.walk")
                    .font(.footnote)
                Spacer()
                Button {
                    clear()
                    withAnimation(.spring(blendDuration: 0.3)) {
                        session.archive.cancel()
                    }
                } label: {
                    Text("CANCEL")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(disabled)
            }
        }
        
        private func clear() {
            disabled = true
            session.health.clear()
            session.location.end()
        }
    }
}
