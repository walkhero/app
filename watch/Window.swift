import SwiftUI
import Hero

struct Window: View {
    @Binding var session: Session
    
    var body: some View {
        if case .none = session.archive.status {
            switch session.section {
            case let .finished(finish):
                Finish(session: $session, finish: finish)
            default:
                Home(session: $session)
            }
        } else {
            Walking(session: $session)
        }
    }
}
