import SwiftUI
import Hero

extension Detail {
    struct Header: View {
        @Binding var session: Session
        let challenge: Challenge
        
        var body: some View {
            HStack {
                Button {
                    withAnimation(.spring(blendDuration: 0.3)) {
                        session.section = .home
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .frame(width: 30, height: 50)
                            .padding(.leading)
                        Text(challenge.title)
                            .font(Font.footnote.bold())
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .foregroundColor(.primary)
                }
                Spacer()
                
                if session.archive.enrolled(challenge) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            session.archive.stop(challenge)
                        }
                    } label: {
                        Text("STOP")
                            .foregroundColor(.secondary)
                            .font(Font.footnote.bold())
                            .frame(width: 60, height: 40)
                    }
                    Button {
                        session.game.leaderboard(challenge)
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.title3)
                            .foregroundColor(.primary)
                            .frame(width: 65, height: 50)
                    }
                }
            }
            Rectangle()
                .fill(Color.secondary)
                .frame(height: 1)
        }
    }
}
