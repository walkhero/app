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
                    let calendar = Cloud.shared.archive.value.calendar
                    Streak(session: $session, year: calendar.last!, streak: calendar.streak)
                case .steps:
                    Steps(session: $session, steps: Cloud.shared.archive.value.steps, max: Cloud.shared.archive.value.maxSteps)
                case .distance:
                    Distance(session: $session, metres: Cloud.shared.archive.value.metres, max: Cloud.shared.archive.value.maxMetres)
                case .map:
                    Mapper(session: $session, bottom: false)
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
                            Cloud.shared.start(challenge)
                        }
                    case .map:
                        session.location.enrollIfNeeded()
                        Cloud.shared.start(challenge)
                    case .streak:
                        Cloud.shared.start(challenge)
                    }
                }
                Spacer()
                    .frame(height: 30)
            }
        }
    }
}
