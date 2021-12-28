import SwiftUI

@main struct App: SwiftUI.App {
    @StateObject private var status = Status()
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    private let game = Game()
    
    var body: some Scene {
        WindowGroup {
            Window(status: status)
        }
        .onChange(of: phase) {
            switch $0 {
            case .active:
                cloud.pull.send()
                game.login(status: status)
            default:
                break
            }
        }
    }
}
