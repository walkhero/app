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
            health.steps(cloud.archive.value)
            health.distance(cloud.archive.value)
            location.start(cloud.archive.value)
            streak = cloud.archive.value.calendar.streak
            maximumSteps = max(cloud.archive.value.maxSteps, Metrics.steps.min)
            maximumMetres = max(cloud.archive.value.maxMetres, Metrics.distance.min)
        }
    }
}
