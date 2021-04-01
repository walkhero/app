import SwiftUI
import Combine
import Hero

extension Walking {
    struct Map: View {
        @Binding var session: Session
        @Binding var tiles: Set<Tile>
        @State private var count = 0
        private let publisher = PassthroughSubject<Set<Tile>, Never>()
        
        var body: some View {
            Text(NSNumber(value: count), formatter: session.decimal)
                .font(Font.largeTitle.bold())
                .padding(.top)
            Text("Map Squares")
                .font(.footnote)
            Text(NSNumber(value: Double(count) / Metrics.map.tiles), formatter: session.percentil)
                .font(Font.callout.monospacedDigit())
                .foregroundColor(.secondary)
                .padding(.bottom)
            WalkHero.Map(session: $session, tiles: publisher)
                .padding(.bottom)
                .onChange(of: tiles) {
                    publisher.send($0)
                    count = $0.count
                }
                .onAppear {
                    publisher.send(tiles)
                    count = tiles.count
                }
        }
    }
}