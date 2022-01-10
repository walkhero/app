import SwiftUI
import UserNotifications

@main struct App: SwiftUI.App {
    @StateObject private var health = Health()
    @State private var walking: Date?
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(health: health, walking: walking)
                .task {
                    cloud.pull.send()
                    
                    location.request()
                    await health.request()
                    _ = await UNUserNotificationCenter.request()
                    
                    game.login()
                }
                .onReceive(cloud) { model in
                    let started = model.walking
                    walking = started
                    
                    if let date = started {
                        if !health.started {
                            health.start(date: date)
                        }
                        
                        if !location.started {
                            location.start()
                        }
                    }
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                cloud.pull.send()
                game.login()
            }
        }
    }
}
