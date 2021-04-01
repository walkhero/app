import SwiftUI

extension Walking {
    struct Menu: View {
        @Binding var session: Session
        @State private var disabled = false
        
        var body: some View {
            VStack {
                Button {
                    clear()
                    
//                    if session.archive.enrolled(.streak) {
//                        session.game.submit(.streak, streak.current)
//                    }
//
//                    if session.archive.enrolled(.steps) {
//                        session.game.submit(.steps, steps)
//                    }
//
//                    if session.archive.enrolled(.distance) {
//                        session.game.submit(.distance, metres)
//                    }
//
//                    if session.archive.enrolled(.map) {
//                        session.game.submit(.map, tiles.count)
//                    }
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
//                        session.archive.end(steps: steps, metres: metres, tiles: tiles)
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
//            session.location.end()
        }
    }
}
