import SwiftUI
import Hero

struct Detail: View {
    @Binding var session: Session
    let challenge: Challenge
    @State private var leaderboard = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.spring(blendDuration: 0.3)) {
                        session.section = .home
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .frame(width: 30, height: 50)
                        .padding(.leading)
                }
                Text(challenge.title)
                    .font(Font.footnote.bold())
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                if session.archive.enrolled(challenge) {
                    Button {
                        leaderboard = true
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.title3)
                            .foregroundColor(.primary)
                            .frame(width: 65, height: 50)
                    }
                    .sheet(isPresented: $leaderboard) {
                        Leaderboards(session: $session, challenge: challenge)
                    }
                }
            }
            if session.archive.enrolled(challenge) {
                switch challenge {
                case .streak:
                    let calendar = session.archive.calendar
                    Streak(session: $session, calendar: calendar, streak: calendar.streak)
                case .steps:
                    Steps(session: $session, steps: session.archive.steps, max: session.archive.maxSteps)
                case .distance:
                    Text("")
                case .map:
                    Text("")
                }
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.archive.stop(challenge)
                    }
                } label: {
                    Text("STOP")
                        .foregroundColor(.secondary)
                        .font(Font.footnote.bold())
                        .frame(width: 300, height: 40)
                }
            } else {
                Spacer()
                Image(systemName: challenge.symbol)
                    .font(.largeTitle)
                Text("New Challenge")
                    .font(.callout)
                    .padding(.top)
                Spacer()
                Control(title: "START", gradient: challenge.background) {
                    switch challenge {
                    case .steps, .distance:
                        session.health.request(challenge) {
                            start()
                        }
                    default: break
                    }
                }
            }
            Spacer()
                .frame(height: 30)
        }
    }
    
    private func start() {
        withAnimation(.easeInOut(duration: 0.3)) {
            session.archive.start(challenge)
        }
    }
}
