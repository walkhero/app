import SwiftUI
import Archivable
import Hero

let cloud = Cloud.new
let health = Health()
let location = Location()
@main struct App: SwiftUI.App {
    var archive = Archive.new
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .onReceive(cloud.archive) {
                    session.archive = $0
                    if case .none = session.archive.status {
                        session.clear()
                    }
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                cloud.pull.send()
            }
        }
    }
}
