import SwiftUI
import Combine
import Hero

extension Walking {
    struct Map: View {
        @Binding var session: Session
        @Binding var tiles: Set<Tile>
        private let publisher = PassthroughSubject<Set<Tile>, Never>()
        
        var body: some View {
            Text(NSNumber(value: session.archive.tiles.count + tiles.count), formatter: session.decimal)
                .font(Font.largeTitle.bold())
                .padding(.top)
            Text("Map Squares")
                .font(.footnote)
            Text(NSNumber(value: Double(session.archive.tiles.count + tiles.count) / Metrics.map.tiles), formatter: session.percentil)
                .font(Font.callout.monospacedDigit())
                .foregroundColor(.secondary)
                .padding(.bottom)
            WalkHero.Map(session: $session, tiles: .init(Array(session.archive.tiles) + .init(tiles)), add: publisher)
                .padding(.bottom)
                .onChange(of: tiles, perform: publisher.send)
        }
    }
}
