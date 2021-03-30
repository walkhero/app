import SwiftUI
import Combine
import Hero

extension Walking {
    struct Map: View {
        @Binding var session: Session
        @Binding var tiles: Set<Tile>
        private let publisher = PassthroughSubject<Set<Tile>, Never>()
        
        var body: some View {
            WalkHero.Map(session: $session, tiles: publisher)
                .padding()
                .onChange(of: tiles) {
                    publisher.send($0)
                }
                .onAppear {
                    publisher.send(tiles)
                }
        }
    }
}
