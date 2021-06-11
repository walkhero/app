import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @State private var status = Status.none
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session, status: status)
                .onReceive(cloud.archive) {
                    status = $0.status
                    if case .none = $0.status {
                        session.clear()
                    }
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                Cloud.shared.pull.send()
            }
        }
    }
}
