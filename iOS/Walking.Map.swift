import SwiftUI
import Combine
import Hero

extension Walking {
    struct Map: View {
        @Binding var session: Session
        @Binding var tiles: Set<Tile>
        private let publisher = PassthroughSubject<Set<Tile>, Never>()
        
        var body: some View {
            Text(NSNumber(value: tiles.count), formatter: session.decimal)
                .font(Font.largeTitle.bold())
                .padding(.top)
            Text("Map Squares")
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.bottom)
            WalkHero.Map(session: $session, tiles: publisher)
                .padding(.bottom)
                .onChange(of: tiles) {
                    publisher.send($0)
                }
                .onAppear {
                    publisher.send(tiles)
                }
        }
    }
}
