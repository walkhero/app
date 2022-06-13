import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @StateObject private var status = Status()
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Main(status: status)
                .task {
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                        Defaults.start()
                        
                        Task
                            .detached {
                                await status.request()
                                await store.launch()
                            }
                    }
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
