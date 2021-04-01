import SwiftUI
import Hero

extension Detail {
    struct Map: View {
        @Binding var session: Session
        
        var body: some View {
            Text(NSNumber(value: session.archive.tiles.count), formatter: session.decimal)
                .font(Font.title2.bold())
                .padding(.top)
            Text("Map Squares")
                .font(.footnote)
            Text(NSNumber(value: Double(session.archive.tiles.count) / Metrics.map.tiles), formatter: session.percentil)
                .font(Font.callout.monospacedDigit())
                .foregroundColor(.secondary)
            WalkHero.Map(session: $session, tiles: session.archive.tiles, add: nil)
            Text("Areas in dark is where you haven't walked yet")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding([.bottom, .horizontal])
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
        }
    }
}
