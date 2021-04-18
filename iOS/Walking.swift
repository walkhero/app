import SwiftUI
import Hero

struct Walking: View {
    @Binding var session: Session
    @Binding var finish: Hero.Finish?
    @State private var challenge: Challenge?
    @State private var disabled = false
    @State private var alert = false
    @State private var steps = 0
    @State private var metres = 0
    @State private var maximumSteps = 1
    @State private var maximumMetres = 1
    @State private var streak = Hero.Streak.zero
    @State private var tiles = Set<Tile>()

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
                    Mapper(session: $session, tiles: tiles, bottom: true)
                }
            } else {
                Time(session: $session)
            }
            
            Control(title: "FINISH", gradient: .init(
                        gradient: .init(colors: [.init(.systemIndigo), .blue]),
                        startPoint: .leading,
                        endPoint: .trailing)) {
                clear()
                
                if session.archive.enrolled(.streak) {
                    session.game.submit(.streak, streak.current)
                }
                
                if session.archive.enrolled(.steps) {
                    session.game.submit(.steps, steps)
                }
                
                if session.archive.enrolled(.distance) {
                    session.game.submit(.distance, metres)
                }
                
                if session.archive.enrolled(.map) {
                    session.game.submit(.map, tiles.count)
                }
                
                if case let .walking(duration) = session.archive.status {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        finish = .init(duration: duration,
                                       streak: streak.current,
                                       steps: steps,
                                       distance: metres,
                                       map: tiles.count)
                        session.archive.end(steps: steps, metres: metres)
                    }
                }
            }
            .disabled(disabled)
            .padding(.top)
            Button {
                alert = true
            } label: {
                Text("CANCEL")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(width: 300, height: 35)
            }
            .disabled(disabled)
            .padding(.top, 10)
            .padding(.bottom)
            .alert(isPresented: $alert) {
                Alert(title: .init("Cancel walk?"),
                      message: .init("Data from this walk will be forgotten"),
                      primaryButton: .default(.init("Continue")),
                      secondaryButton: .destructive(.init("Cancel")) {
                        clear()
                        withAnimation(.easeInOut(duration: 0.3)) {
                            session.archive.cancel()
                        }
                })
            }
        }
        .onReceive(session.health.steps.receive(on: DispatchQueue.main)) {
            guard !disabled else { return }
            steps = $0
        }
        .onReceive(session.health.distance.receive(on: DispatchQueue.main)) {
            guard !disabled else { return }
            metres = $0
        }
        .onReceive(session.location.tiles.receive(on: DispatchQueue.main)) {
            guard !disabled else { return }
            session.archive.discover($0)
            tiles = session.archive.tiles
        }
        .onAppear {
            session.health.steps(session.archive)
            session.health.distance(session.archive)
            session.location.start(session.archive)
            streak = session.archive.calendar.streak
            maximumSteps = max(session.archive.maxSteps, Metrics.steps.min)
            maximumMetres = max(session.archive.maxMetres, Metrics.distance.min)
            disabled = false
        }
    }
    
    private func clear() {
        disabled = true
        session.clear()
    }
}
