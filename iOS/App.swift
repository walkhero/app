import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @StateObject private var status = Status()
    @State private var froob = false
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Main(status: status)
                .sheet(isPresented: $froob, content: Froob.init)
                .task {
                    cloud.pull.send()
                    
                    switch Defaults.action {
                    case .rate:
                        UIApplication.shared.review()
                    case .froob:
                        DispatchQueue
                            .main
                            .asyncAfter(deadline: .now() + 1) {
                                froob = true
                            }
                    case .none:
                        break
                    }
                    
                    await status.request()
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
