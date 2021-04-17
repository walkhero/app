import SwiftUI
import Hero

extension Detail {
    struct Streak: View {
        @Binding var session: Session
        let year: Year
        let streak: Hero.Streak
        
        var body: some View {
            Spacer()
            Header(session: $session, streak: streak)
            Ephemeris(index: year.months.count - 1, monther: session.monther, weeker: session.weeker, year: year)
            Spacer()
        }
    }
}
