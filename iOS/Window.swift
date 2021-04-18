import SwiftUI
import Hero

struct Window: View {
    @Binding var session: Session
    @State private var finish: Hero.Finish?
    
    var body: some View {
        if finish != nil {
            Finish(session: $session, finish: $finish)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
        } else if case .none = session.archive.status {
            switch session.section {
            case .home:
                Home(session: $session)
                    .transition(.move(edge: .leading))
            case .listed:
                Listed(session: $session, list: session.archive.list)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            case let .challenge(challenge):
                Detail(session: $session, challenge: challenge)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }
        } else {
            Walking(session: $session, finish: $finish)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
        }
    }
}
