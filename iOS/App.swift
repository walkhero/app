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
                    switch Defaults.action {
                    case .rate:
                        UIApplication.shared.review()
                    case .froob:
                        DispatchQueue
                            .main
                            .asyncAfter(deadline: .now() + 1) {
                                status.froob = true
                            }
                    case .none:
                        break
                    }

                    await status.request()

                    await cloud.migrate(directory: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
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
