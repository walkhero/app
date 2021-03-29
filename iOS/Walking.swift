import SwiftUI
import Hero

struct Walking: View {
    @Binding var session: Session
    @State private var challenge: Challenge?
    @State private var disabled = false
    @State private var steps = 500
    @State private var metres = 0
    @State private var maximumSteps = 1000
    @State private var maximumMetres = 1
    @State private var streak = Hero.Streak.zero

    var body: some View {
        VStack {
            Segmented(session: $session, challenge: $challenge)
                .padding(.bottom)
            
            switch challenge {
            case .streak:
                Streak(session: $session, streak: streak)
            case .steps:
                Steps(session: $session, steps: $steps, maximum: maximumSteps)
            case .distance:
                Distance(session: $session, metres: $metres, maximum: maximumMetres)
            default:
                Time(session: $session)
            }
            
            Control(title: "FINISH", gradient: .init(
                        gradient: .init(colors: [.init(.systemIndigo), .blue]),
                        startPoint: .leading,
                        endPoint: .trailing)) {
                disabled = true
                
                if session.archive.enrolled(.streak) {
                    session.game.submit(.streak, streak.current)
                }
                if session.archive.enrolled(.steps) {
                    session.game.submit(.steps, steps)
                }
                if session.archive.enrolled(.distance) {
                    session.game.submit(.distance, metres)
                }
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    session.archive.end(steps: steps, metres: metres)
                }
            }
            .disabled(disabled)
            .padding(.top)
            Button {
                withAnimation(.spring(blendDuration: 0.3)) {
                    session.archive.cancel()
                }
            } label: {
                Text("CANCEL")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(width: 300, height: 34)
            }
            .disabled(disabled)
            .padding(.top, 10)
            .padding(.bottom)
        }
        .onReceive(session.health.steps.receive(on: DispatchQueue.main)) { _ in
//            steps = $0
        }
        .onReceive(session.health.distance.receive(on: DispatchQueue.main)) {
            metres = $0
        }
        .onAppear {
            session.health.steps(session.archive)
            session.health.distance(session.archive)
            streak = session.archive.calendar.streak
//            maximumSteps = max(session.archive.maxSteps, Metrics.steps.min)
            maximumMetres = max(session.archive.maxMetres, Metrics.distance.min)
        }
        .onDisappear(perform: session.health.clear)
    }
}
