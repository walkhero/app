import SwiftUI
import Hero

struct Walking: View {
    @Binding var session: Session
    @State private var streak = Hero.Streak.zero
    @State private var steps = 0
    @State private var metres = 0
    @State private var maximumSteps = 1
    @State private var maximumMetres = 1
    
    var body: some View {
        TabView {
            Menu(session: $session, steps: steps, metres: metres)
            Time(session: $session)
            
            if session.archive.enrolled(.streak) {
                Streak(session: $session, streak: streak)
            }
            
            if session.archive.enrolled(.steps) {
                Steps(session: $session, steps: steps, maximum: maximumSteps)
            }
            
            if session.archive.enrolled(.distance) {
                Distance(session: $session, metres: metres, maximum: maximumMetres)
            }
            
            if session.archive.enrolled(.map) {
                Map(session: $session)
            }
        }
        .tabViewStyle(PageTabViewStyle())
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
