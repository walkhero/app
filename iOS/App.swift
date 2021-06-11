import SwiftUI
import Archivable
import Hero

let cloud = Cloud.new
let game = Game()
let health = Health()
let location = Location()
let purchases = Purchases()
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
                .onReceive(cloud.archive) {
                    session.archive = $0
                    if case .none = session.archive.status {
                        session.clear()
                    }
                    if session.archive.finish.publish {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            guard game.publishing else { return }

                            if session.archive.enrolled(.streak) {
                                game.submit(.streak, session.archive.finish.streak)
                            }
                            
                            if session.archive.enrolled(.steps) {
                                game.submit(.steps, session.archive.finish.steps)
                            }
                            
                            if session.archive.enrolled(.distance) {
                                game.submit(.distance, session.archive.finish.metres)
                            }
                            
                            if session.archive.enrolled(.map) {
                                game.submit(.map, session.archive.finish.area)
                            }
                            
                            cloud.publish()
                        }
                    }
                }
                .onReceive(game.name) { name in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.player.name = name
                    }
                }
                .onReceive(game.image) { image in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.player.image = image
                    }
                }
                .onReceive(purchases.open) {
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
                cloud.pull.send()
                game.login()
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
