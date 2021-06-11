import SwiftUI
import Hero

struct Walking: View {
    @Binding var session: Session
    @State private var challenge: Challenge?
    @State private var alert = false
    @State private var steps = 0
    @State private var metres = 0
    @State private var maximumSteps = 1
    @State private var maximumMetres = 1
    @State private var streak = Hero.Streak.zero

    var body: some View {
        VStack {
            Segmented(session: $session, challenge: $challenge)
                .padding(.bottom)
            
            if let challenge = challenge {
                switch challenge {
                case .streak:
                    Streak(session: $session, streak: streak)
                case .steps:
                    Steps(session: $session, steps: $steps, maximum: maximumSteps)
                case .distance:
                    Distance(session: $session, metres: $metres, maximum: maximumMetres)
                case .map:
                    Mapper(session: $session, bottom: true)
                }
            } else {
                Time(session: $session)
            }
            
            Control(title: "FINISH", gradient: .init(
                        gradient: .init(colors: [.init(.systemIndigo), .blue]),
                        startPoint: .leading,
                        endPoint: .trailing)) {
                session.clear()
                
                cloud.finish(steps: steps, metres: metres) { finish in
                    withAnimation(.easeInOut(duration: 0.4)) {
                        session.section = .finished(finish)
                    }
                }
            }
            .padding(.top)
            Button {
                alert = true
            } label: {
                Text("CANCEL")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(width: 300, height: 35)
            }
            .padding(.top, 10)
            .padding(.bottom)
            .alert(isPresented: $alert) {
                Alert(title: .init("Cancel walk?"),
                      message: .init("Data from this walk will be forgotten"),
                      primaryButton: .default(.init("Continue")),
                      secondaryButton: .destructive(.init("Cancel")) {
                        session.clear()
                        cloud.cancel()
                })
            }
        }
        .onReceive(health.steps.receive(on: DispatchQueue.main)) {
            steps = $0
        }
        .onReceive(health.distance.receive(on: DispatchQueue.main)) {
            metres = $0
        }
        .onReceive(location.tiles.receive(on: DispatchQueue.main)) {
            cloud.discover($0)
        }
        .onAppear {
            health.steps(session.archive)
            health.distance(session.archive)
            location.start(session.archive)
            streak = session.archive.calendar.streak
            maximumSteps = max(session.archive.maxSteps, Metrics.steps.min)
            maximumMetres = max(session.archive.maxMetres, Metrics.distance.min)
        }
    }
}
