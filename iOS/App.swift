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
                    if session.chart.walks == 0 {
                        session.loaded = false
                    }
                    
                    session.walking = model.walking
                    
                    Task
                        .detached {
                            await session.update(chart: model.chart, tiles: model.tiles)
                        }
                }
                .task {
                    session.ready = false
                    session.loaded = false
                    
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                        Defaults.start()
                        session.ready = true
                        
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
