import SwiftUI
import CoreLocation
import HealthKit
import Hero

@main struct App: SwiftUI.App {
    @StateObject private var session = Session()
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: session)
                .onReceive(cloud) { model in
                    session.walking = model.walking
                    
                    Task
                        .detached(priority: .utility) {
                            await session.update(chart: model.chart, tiles: model.tiles)
                        }
                }
                .task {
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                        Defaults.start()
                        session.loaded = true
                        
                        Task
                            .detached {
                                await request()
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
    
    private func request() async {
        let manager = CLLocationManager()
        if manager.authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        }
        
        _ = await UNUserNotificationCenter.request()
        
        if HKHealthStore.isHealthDataAvailable() {
            try? await HKHealthStore()
                .requestAuthorization(toShare: [],
                                      read: .init([Challenge.steps, .metres, .calories]
                                        .compactMap(\.object)))
        }
    }
}
