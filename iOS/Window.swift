import SwiftUI

struct Window: View {
    @ObservedObject var session: Session
    
    var body: some View {
        content
            .animation(.easeInOut(duration: 0.4), value: session.walking)
    }
    
    @ViewBuilder private var content: some View {
        if session.loaded, let chart = session.chart {
            if let leaf = session.achievement {
                Achievement(session: session, leaf: leaf)
                    .transition(.opacity)
            } else if let summary = session.summary {
                Results(session: session, summary: summary)
                    .equatable()
                    .transition(.opacity)
            } else if session.walking > 0 {
                Walking(session: session, chart: chart)
                    .transition(.opacity)
            } else {
                Main(session: session, chart: chart)
                    .transition(.asymmetric(insertion: .move(edge: .bottom),
                                            removal: .move(edge: .top)))
            }
        } else {
            Image("Logo")
                .foregroundColor(.secondary)
                .frame(maxHeight: .greatestFiniteMagnitude)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
