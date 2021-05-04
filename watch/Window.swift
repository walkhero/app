import SwiftUI
import Hero

struct Window: View {
    @Binding var session: Session
    let status: Status
    
    var body: some View {
        if case .none = status {
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
