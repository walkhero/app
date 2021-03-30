import SwiftUI
import Combine
import Hero

extension Detail {
    struct Map: View {
        @Binding var session: Session
        private let publisher = PassthroughSubject<Set<Tile>, Never>()
        
        var body: some View {
            HStack(alignment: .bottom) {
                VStack {
                    Text(NSNumber(value: session.archive.tiles.count), formatter: session.decimal)
                        .font(Font.title2.bold())
                    Text("Map Squares")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                VStack {
                    Text(NSNumber(value: Double(session.archive.tiles.count) / pow(4, 20)), formatter: session.percentil)
                        .font(Font.body.bold())
                    Text("World Covered")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top)
            WalkHero.Map(session: $session, tiles: publisher)
            Text("Areas in dark is where you haven't walked yet")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding([.horizontal, .bottom])
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .onAppear {
                    publisher.send(session.archive.tiles)
                }
        }
    }
}
