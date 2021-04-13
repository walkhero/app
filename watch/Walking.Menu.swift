import SwiftUI
import Hero

extension Walking {
    struct Menu: View {
        @Binding var session: Session
        @Binding var transport: Transport?
        let streak: Int
        let steps: Int
        let metres: Int
        let tiles: Int
        @State private var disabled = false
        @State private var alert = false
        
        var body: some View {
            VStack {
                Button {
                    alert = true
                } label: {
                    Text("CANCEL")
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .padding(6)
                }
                .alert(isPresented: $alert) {
                    Alert(title: .init("Cancel walk?"),
                          primaryButton: .default(.init("Continue")),
                          secondaryButton: .destructive(.init("Cancel")) {
                            clear()
                            withAnimation(.easeInOut(duration: 0.3)) {
                                session.archive.cancel()
                            }
                    })
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(disabled)
                Spacer()
                Image(systemName: "figure.walk")
                    .font(.title2)
                Spacer()
                Button {
                    clear()
                    let transport = Transport(streak: streak, steps: steps, distance: metres, map: tiles)
                    session.watch.send(transport)
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.archive.end(steps: steps, metres: metres)
                        self.transport = transport
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
            .onAppear {
                disabled = false
            }
        }
        
        private func clear() {
            disabled = true
            session.clear()
        }
    }
}
