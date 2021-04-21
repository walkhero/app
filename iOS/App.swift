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
                    if session.archive.finish.publish {
                        session.publish.send()
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
                .onReceive(session.purchases.open) {
                    modal(.store)
                }
                .onReceive(delegate.froob) {
                    modal(.froob)
                }
                .onReceive(session.publish) {
                    if session.archive.enrolled(.streak) {
                        session.game.submit(.streak, session.archive.finish.streak)
                    }
                    
                    if session.archive.enrolled(.steps) {
                        session.game.submit(.steps, session.archive.finish.steps)
                    }
                    
                    if session.archive.enrolled(.distance) {
                        session.game.submit(.distance, session.archive.finish.metres)
                    }
                    
                    if session.archive.enrolled(.map) {
                        session.game.submit(.map, session.archive.finish.area)
                    }
                    
                    session.archive.publish()
                }
                .onReceive(session.dismiss) {
                    UIApplication.shared.dismiss()
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                Repository.memory.pull.send()
                session.game.login()
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
