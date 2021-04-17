import SwiftUI
import Hero

struct Detail: View {
    @Binding var session: Session
    let challenge: Challenge
    
    var body: some View {
        VStack {
            Header(session: $session, challenge: challenge)
            if session.archive.enrolled(challenge) {
                switch challenge {
                case .streak:
                    let calendar = session.archive.calendar
                    Streak(session: $session, year: calendar.last!, streak: calendar.streak)
                case .steps:
                    Steps(session: $session, steps: session.archive.steps, max: session.archive.maxSteps)
                case .distance:
                    Distance(session: $session, metres: session.archive.metres, max: session.archive.maxMetres)
                case .map:
                    Mapper(session: $session, tiles: session.archive.tiles, bottom: false)
                        .edgesIgnoringSafeArea(.bottom)
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
                    case .map:
                        session.location.enrollIfNeeded()
                        start()
                    case .streak:
                        start()
                    }
                }
                Spacer()
                    .frame(height: 30)
            }
        }
    }
    
    private func start() {
        withAnimation(.easeInOut(duration: 0.3)) {
            session.archive.start(challenge)
        }
    }
}
