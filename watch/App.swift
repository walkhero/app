import SwiftUI
import WatchConnectivity
import Combine
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .onReceive(Repository.memory.archive) {
                    session.archive = $0
                    if case .none = session.archive.status {
                        session.clear()
                    }
                }
                .onAppear(perform: refresh)
        }
        .onChange(of: phase) {
            if $0 == .active {
                refresh()
            }
        }
    }
    
    private func refresh() {
        Repository.memory.pull.send()
        
        if WCSession.default.activationState != .activated {
            WCSession.default.delegate = session.watch
            WCSession.default.activate()
        }
        
        session.game.login()
    }
}
