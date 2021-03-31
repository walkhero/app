import SwiftUI
import Hero

struct Walking: View {
    @Binding var session: Session
    @State private var streak = Hero.Streak.zero
    
    var body: some View {
        TabView {
            Menu(session: $session)
            Time(session: $session)
            Streak(session: $session, streak: streak)
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            streak = session.archive.calendar.streak
        }
    }
}
