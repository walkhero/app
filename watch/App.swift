import SwiftUI
import WatchConnectivity
import Combine
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @WKExtensionDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .onReceive(Memory.shared.archive) {
                    session.archive = $0
                    if case .none = session.archive.status {
                        session.clear()
                    }
                }
                .onAppear {
                    if session.archive == .new {
                        Memory.shared.load()
                    }
                    
                    Memory.shared.fetch()
                    
                    if WCSession.default.activationState != .activated {
                        WCSession.default.delegate = session.watch
                        WCSession.default.activate()
                    }
                }
        }
    }
}
