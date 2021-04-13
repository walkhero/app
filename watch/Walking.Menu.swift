import SwiftUI

extension Walking {
    struct Menu: View {
        @Binding var session: Session
        let streak: Int
        let steps: Int
        let metres: Int
        let tiles: Int
        @State private var disabled = false
        
        var body: some View {
            VStack {
                Button {
                    clear()
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.archive.cancel()
                    }
                } label: {
                    Text("CANCEL")
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .padding(6)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(disabled)
                Spacer()
                Image(systemName: "figure.walk")
                    .font(.title2)
                Spacer()
                Button {
                    clear()
                    session.watch.send(.init(streak: streak, steps: steps, distance: metres, map: tiles))
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.archive.end(steps: steps, metres: metres)
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .fill(LinearGradient(
                                    gradient: .init(colors: [.purple, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing))
                        Text("FINISH")
                            .foregroundColor(.black)
                            .font(.callout)
                            .fontWeight(.medium)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 6)
                    }
                    .fixedSize()
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(disabled)
            }
        }
        
        private func clear() {
            disabled = true
            session.clear()
        }
    }
}
