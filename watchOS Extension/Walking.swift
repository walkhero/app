import SwiftUI

struct Walking: View {
    @ObservedObject var session: Session
    @StateObject private var walker = Walker()
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Info(session: session, walker: walker)
            Actions(session: session, walker: walker)
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
