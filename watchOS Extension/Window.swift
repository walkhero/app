import SwiftUI

struct Window: View {
    @ObservedObject var session: Session
    
    var body: some View {
        content
            .animation(.easeInOut(duration: 0.7), value: session.walking)
    }
    
    @ViewBuilder private var content: some View {
        if session.loading {
            Image("Logo")
                .foregroundColor(.secondary)
                .frame(maxHeight: .greatestFiniteMagnitude)
                .edgesIgnoringSafeArea(.all)
        } else if let summary = session.summary {
           Results(session: session, summary: summary)
       } else if session.walking > 0 {
            Walking(session: session)
        } else {
            Main(session: session)
        }
    }
}
