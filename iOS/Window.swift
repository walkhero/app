import SwiftUI

struct Window: View {
    @ObservedObject var session: Session
    
    var body: some View {
        content
            .animation(.easeInOut(duration: 0.4), value: session.walking)
    }
    
    @ViewBuilder private var content: some View {
        if session.loading {
            Image("Logo")
                .foregroundColor(.init(.tertiaryLabel))
                .frame(maxHeight: .greatestFiniteMagnitude)
                .edgesIgnoringSafeArea(.all)
        } else if session.walking > 0 {
            Walking(session: session, walker: .init(session: session))
                .transition(.asymmetric(insertion: .move(edge: .bottom),
                                        removal: .move(edge: .top)))
        } else {
            Main(session: session)
                .transition(.asymmetric(insertion: .move(edge: .bottom),
                                        removal: .move(edge: .top)))
        }
    }
}
