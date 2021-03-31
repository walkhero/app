import SwiftUI

struct Control: View {
    @Binding var session: Session
    
    var body: some View {
        VStack {
            Text(session.player.name)
                .foregroundColor(.accentColor)
                .font(Font.callout.bold())
            if case .none = session.archive.status {
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
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .fixedSize()
                Spacer()
                Image(systemName: "figure.walk")
                    .font(.title2)
            } else {
                
            }
        }
    }
}
