import SwiftUI
import WidgetKit
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .onReceive(Memory.shared.archive) {
                    session.archive = $0
                    if case .none = session.archive.status {
                        session.clear()
                    }
                }
                .onReceive(session.game.name) { name in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.player.name = name
                    }
                }
                .onReceive(session.game.image) { image in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.player.image = image
                    }
                }
                .onReceive(session.widget) {
                    Defaults.archive = $0
                    WidgetCenter.shared.reloadAllTimelines()
                }
                .onReceive(session.watch.challenges.receive(on: DispatchQueue.main)) {
                    if session.archive.enrolled(.streak) {
                        session.game.submit(.streak, $0.streak)
                    }
                    
                    if session.archive.enrolled(.steps) {
                        session.game.submit(.steps, $0.steps)
                    }
                    
                    if session.archive.enrolled(.distance) {
                        session.game.submit(.distance, $0.distance)
                    }
                    
                    if session.archive.enrolled(.map) {
                        session.game.submit(.map, $0.map)
                    }
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                if session.archive == .new {
                    Memory.shared.load()
                }
                
                Memory.shared.fetch()
                session.game.login()
                session.watch.activate()
            }
        }
    }
}
