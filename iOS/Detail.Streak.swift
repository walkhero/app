import SwiftUI
import Hero

extension Detail {
    struct Streak: View {
        @Binding var session: Session
        let calendar: [Year]
        let streak: Hero.Streak
        
        var body: some View {
            Header(session: $session, streak: streak)
            Spacer()
            if let year = calendar.last {
                Ephemeris(session: $session, index: year.months.count - 1, year: year)
            } else {
                Image(systemName: Challenge.streak.symbol)
                    .font(.largeTitle)
                Text("Ready to start\nyour streak")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }
        }
    }
}
