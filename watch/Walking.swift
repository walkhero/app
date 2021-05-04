import SwiftUI
import Archivable
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
            
            if Cloud.shared.archive.value.enrolled(.streak) {
                Streak(session: $session, streak: streak)
            }
            
            if Cloud.shared.archive.value.enrolled(.steps) {
                Steps(session: $session, steps: steps, maximum: maximumSteps)
            }
            
            if Cloud.shared.archive.value.enrolled(.distance) {
                Distance(session: $session, metres: metres, maximum: maximumMetres)
            }
            
            if Cloud.shared.archive.value.enrolled(.map) {
                Map(session: $session)
            }
        }
        .tabViewStyle(PageTabViewStyle())
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
            session.health.steps(Cloud.shared.archive.value)
            session.health.distance(Cloud.shared.archive.value)
            session.location.start(Cloud.shared.archive.value)
            streak = Cloud.shared.archive.value.calendar.streak
            maximumSteps = max(Cloud.shared.archive.value.maxSteps, Metrics.steps.min)
            maximumMetres = max(Cloud.shared.archive.value.maxMetres, Metrics.distance.min)
        }
    }
}
