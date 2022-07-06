import SwiftUI
import Hero

struct Walking: View {
    @ObservedObject var session: Session
    let chart: Chart
    @StateObject private var walker = Walker()
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Info(walker: walker, session: session, chart: chart)
                .edgesIgnoringSafeArea(.all)
            Actions(session: session, walker: walker, chart: chart)
        }
        .onChange(of: session.tiles) {
            walker.tiles = $0
        }
        .onDisappear {
            Task {
                await walker.clear()
            }
        }
        .task {
            walker.tiles = session.tiles
            await walker.start(date: .init(timestamp: session.walking))
        }
    }
}
