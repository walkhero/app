import SwiftUI
import Hero

extension Walking {
    struct Menu: View {
        @Binding var session: Session
        @Binding var finish: Hero.Finish?
        let steps: Int
        let metres: Int
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
                .buttonStyle(PlainButtonStyle())
                .alert(isPresented: $alert) {
                    Alert(title: .init("Cancel walk?"),
                          primaryButton: .default(.init("Continue")),
                          secondaryButton: .destructive(.init("Cancel")) {
                            session.clear()
                            withAnimation(.easeInOut(duration: 0.3)) {
                                session.archive.cancel()
                            }
                    })
                }
                Spacer()
                Image(systemName: "figure.walk")
                    .font(.title2)
                Spacer()
                Button {
                    session.clear()
                    withAnimation(.easeInOut(duration: 0.4)) {
                        session.archive.finish(steps: steps, metres: metres)
                        finish = session.archive.finish
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
            }
        }
    }
}
