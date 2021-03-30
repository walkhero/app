import SwiftUI
import Combine
import Hero

extension Detail {
    struct Map: View {
        @Binding var session: Session
        private let publisher = PassthroughSubject<Set<Tile>, Never>()
        
        var body: some View {
            Text(NSNumber(value: session.archive.tiles.count), formatter: session.decimal)
                .font(Font.title2.bold())
                .padding(.top)
            Text("Map Squares")
                .font(.footnote)
            Text(NSNumber(value: Double(session.archive.tiles.count) / Metrics.map.tiles), formatter: session.percentil)
                .font(Font.callout.monospacedDigit())
                .foregroundColor(.secondary)
            WalkHero.Map(session: $session, tiles: publisher)
            Text("Areas in dark is where you haven't walked yet")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .padding(.bottom)
                .onAppear {
                    publisher.send(session.archive.tiles)
                }
        }
    }
}
