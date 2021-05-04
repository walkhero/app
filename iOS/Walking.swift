import SwiftUI
import Archivable
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
                
                withAnimation(.easeInOut(duration: 0.4)) {
                    Cloud.shared.finish(steps: steps, metres: metres)
                    session.section = .finished(session.archive.finish)
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
                        Cloud.shared.cancel()
                })
            }
        }
        .onReceive(session.health.steps.receive(on: DispatchQueue.main)) {
            steps = $0
        }
        .onReceive(session.health.distance.receive(on: DispatchQueue.main)) {
            metres = $0
        }
        .onReceive(session.location.tiles.receive(on: DispatchQueue.main)) {
            Cloud.shared.discover($0)
        }
        .onAppear {
            session.health.steps(session.archive)
            session.health.distance(session.archive)
            session.location.start(session.archive)
            streak = Cloud.shared.archive.value.calendar.streak
            maximumSteps = max(Cloud.shared.archive.value.maxSteps, Metrics.steps.min)
            maximumMetres = max(Cloud.shared.archive.value.maxMetres, Metrics.distance.min)
        }
    }
}
