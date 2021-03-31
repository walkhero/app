import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .onReceive(Memory.shared.archive) {
                    session.archive = $0
                }
                .onReceive(session.game.name) { name in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.player.name = name
                    }
                }
                .onAppear {
                    Memory.shared.load()
                    Memory.shared.fetch()
                    session.game.login()
                }
        }
    }
}
