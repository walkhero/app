import SwiftUI

struct Window: View {
    @Binding var session: Session
    
    var body: some View {
        if case .none = session.archive.status {
            Home(session: $session)
        } else {
            TabView {
                Control(session: $session)
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
