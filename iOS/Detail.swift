import SwiftUI
import Hero

struct Detail: View {
    @Binding var session: Session
    let challenge: Challenge
    
    var body: some View {
        VStack {
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
                        session.modal = .challenge(challenge)
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.title3)
                            .foregroundColor(.primary)
                            .frame(width: 65, height: 50)
                    }
                }
            }
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
                    Map(session: $session)
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
                    case .map:
                        session.location.enroll()
                        start()
                    case .streak:
                        start()
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
