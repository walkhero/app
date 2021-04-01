import SwiftUI
import Combine
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) var delegate
    @State private var first = true
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .onReceive(Memory.shared.archive) {
                    session.archive = $0
                }
                .onAppear {
                    if first {
                        first = false
                        Memory.shared.load()
                    }
                }
        }
    }
}
