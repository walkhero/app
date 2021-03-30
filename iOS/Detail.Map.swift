import SwiftUI
import Combine
import Hero

extension Detail {
    struct Map: View {
        @Binding var session: Session
        private let publisher = PassthroughSubject<Set<Tile>, Never>()
        
        var body: some View {
            WalkHero.Map(session: $session, tiles: publisher)
                .padding()
        }
    }
}
