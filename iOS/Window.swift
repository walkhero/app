import SwiftUI

struct Window: View {
    @Binding var session: Session
    
    var body: some View {
        if case .none = session.archive.status {
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
            }
        } else {
            Walking(session: $session)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
        }
    }
}
