import SwiftUI
import Hero

struct Window: View {
    @Binding var session: Session
    @State private var finish: Hero.Finish?
    
    var body: some View {
        if finish != nil {
            Finish(session: $session, finish: $finish)
        } else if case .none = session.archive.status {
            Home(session: $session)
        } else {
            Walking(session: $session, finish: $finish)
        }
    }
}
