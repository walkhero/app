import SwiftUI

struct Home: View {
    @Binding var session: Session
    
    var body: some View {
        VStack {
            Text(session.player.name)
                .foregroundColor(.accentColor)
                .font(Font.callout.bold())
            Spacer()
            Button {
                withAnimation(.spring(blendDuration: 0.4)) {
                    session.archive.start()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                                gradient: .init(colors: [.blue, .purple]),
                                startPoint: .top,
                                endPoint: .bottom))
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .buttonStyle(PlainButtonStyle())
            .fixedSize()
            Spacer()
            Image(systemName: "figure.walk")
                .font(.title2)
        }
    }
}
