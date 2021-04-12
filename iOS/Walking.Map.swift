import SwiftUI
import Hero

extension Walking {
    struct Map: View {
        @Binding var session: Session
        let tiles: Set<Tile>
        
        var body: some View {
            Text(NSNumber(value: tiles.count), formatter: session.decimal)
                .font(Font.largeTitle.bold())
                .padding(.top)
            Text("Map Squares")
                .font(.footnote)
            Text(NSNumber(value: Double(tiles.count) / Metrics.map.tiles), formatter: session.percentil)
                .font(Font.callout.monospacedDigit())
                .foregroundColor(.secondary)
                .padding(.bottom)
            WalkHero.Map(session: $session, tiles: tiles)
                .padding(.bottom)
        }
    }
}
