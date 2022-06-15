import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @StateObject private var session = Sesssion()
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: session)
                .onReceive(cloud) { model in
                    session.walking = model.walking
                    
                    Task
                        .detached(priority: .utility) {
                            await chart(chart: model.chart)
                        }
                }
                .task {
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                        Defaults.start()
                        
                        Task
                            .detached {
//                                await status.request()
                                await store.launch()
                            }
                        
                        session.loading = false
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
    
    private func chart(chart: Chart) {
        session.chart = chart
    }
}
