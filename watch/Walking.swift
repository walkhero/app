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
            Menu(session: $session)
            Time(session: $session)
            Streak(session: $session, streak: streak)
            Steps(session: $session, steps: $steps, maximum: maximumSteps)
            Distance(session: $session, metres: $metres, maximum: maximumMetres)
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            session.health.steps(session.archive)
            session.health.distance(session.archive)
//            session.location.start(session.archive)
            streak = session.archive.calendar.streak
            maximumSteps = max(session.archive.maxSteps, Metrics.steps.min)
            maximumMetres = max(session.archive.maxMetres, Metrics.distance.min)
        }
    }
}
