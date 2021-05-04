import SwiftUI
import Hero

struct Window: View {
    @Binding var session: Session
    let status: Status
    
    var body: some View {
        if case .none = status {
            switch session.section {
            case .home:
                Home(session: $session)
                    .transition(.move(edge: .leading))
            case .listed:
                Listed(session: $session)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            case let .challenge(challenge):
                Detail(session: $session, challenge: challenge)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            case let .finished(finish):
                Finish(session: $session, finish: finish)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }
        } else {
            Walking(session: $session)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
        }
    }
}
