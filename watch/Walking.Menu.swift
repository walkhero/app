import SwiftUI

extension Walking {
    struct Menu: View {
        @Binding var session: Session
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
                            cloud.cancel()
                    })
                }
                Spacer()
                Image(systemName: "figure.walk")
                    .font(.title2)
                Spacer()
                Button {
                    session.clear()
                    DispatchQueue.main.async {
                        cloud.finish(steps: steps, metres: metres) {
                            session.section = .finished($0)
                        }
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
