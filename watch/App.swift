import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .onReceive(Repository.memory.archive) {
                    session.archive = $0
                    if case .none = session.archive.status {
                        session.clear()
                    }
                }
                .onAppear(perform: Repository.memory.pull.send)
        }
        .onChange(of: phase) {
            if $0 == .active {
                Repository.memory.pull.send()
            }
        }
    }
}
