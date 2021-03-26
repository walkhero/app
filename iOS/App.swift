import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
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
                .onReceive(session.game.image) { image in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.player.image = image
                    }
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                Memory.shared.fetch()
                session.game.login()
            }
        }
    }
}
