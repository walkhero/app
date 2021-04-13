import SwiftUI
import Hero

struct Window: View {
    @Binding var session: Session
    @State private var transport: Transport?
    
    var body: some View {
        if transport != nil {
            Finish(session: $session, transport: $transport)
        } else if case .none = session.archive.status {
            Home(session: $session)
        } else {
            Walking(session: $session, transport: $transport)
        }
    }
}
