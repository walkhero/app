import SwiftUI

@main struct App: SwiftUI.App {
    @StateObject private var status = Status()
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Main(status: status)
                .task {
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                    }
                    
                    await status.request()
                    WKExtension.shared().registerForRemoteNotifications()
                }
        }
        .onChange(of: phase) {
            switch $0 {
            case .active:
                cloud.pull.send()
            default:
                break
            }
        }
    }
}
