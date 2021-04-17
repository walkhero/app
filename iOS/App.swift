import SwiftUI
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session)
                .sheet(item: $session.modal) {
                    switch $0 {
                    case .store: Settings(session: $session)
                    case .froob: Settings.Froob(session: $session)
                    }
                }
                .onReceive(Repository.memory.archive) {
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
                .onReceive(session.challenges) {
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
                .onReceive(session.purchases.open) {
                    modal(.store)
                }
                .onReceive(delegate.froob) {
                    modal(.froob)
                }
                .onReceive(session.dismiss) {
                    UIApplication.shared.dismiss()
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                Repository.memory.pull.send()
                session.game.login()
                session.watch.activate()
            }
        }
    }
    
    private func modal(_ mode: Session.Modal) {
        if session.modal == nil {
            session.modal = mode
        } else {
            session.dismiss.send()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                session.modal = mode
            }
        }
    }
}
