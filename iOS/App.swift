import SwiftUI
import Archivable
import Hero

@main struct App: SwiftUI.App {
    @State private var session = Session()
    @State private var status = Status.none
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Window(session: $session, status: status)
                .sheet(item: $session.modal) {
                    switch $0 {
                    case .store: Settings(session: $session)
                    case .froob: Settings.Froob(session: $session)
                    }
                }
                .onReceive(Cloud.shared.archive) { archive in
                    status = archive.status
                    if case .none = archive.status {
                        session.clear()
                    }
                    if archive.finish.publish {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            guard session.game.publishing else { return }

                            if archive.enrolled(.streak) {
                                session.game.submit(.streak, archive.finish.streak)
                            }
                            
                            if archive.enrolled(.steps) {
                                session.game.submit(.steps, archive.finish.steps)
                            }
                            
                            if archive.enrolled(.distance) {
                                session.game.submit(.distance, archive.finish.metres)
                            }
                            
                            if archive.enrolled(.map) {
                                session.game.submit(.map, archive.finish.area)
                            }
                            
                            Cloud.shared.publish()
                        }
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
                .onReceive(session.dismiss) {
                    UIApplication.shared.dismiss()
                }
        }
        .onChange(of: phase) {
            if $0 == .active {
                Cloud.shared.pull.send()
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
