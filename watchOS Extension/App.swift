import SwiftUI
import CoreLocation
import HealthKit

@main struct App: SwiftUI.App {
    @StateObject private var session = Session()
    @State private var first = true
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
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
                    guard first else { return }
                    
                    first = false
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                        session.loading += 1
                        
                        Task
                            .detached {
                                await request()
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
        
        if HKHealthStore.isHealthDataAvailable() {
            try? await HKHealthStore()
                .requestAuthorization(toShare: [],
                                      read: .init([Challenge.steps, .metres, .calories]
                                        .compactMap(\.object)))
        }
    }
}
