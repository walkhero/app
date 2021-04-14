import SwiftUI
import Hero

struct Mapper: View {
    @Binding var session: Session
    let tiles: Set<Tile>
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(NSNumber(value: tiles.count), formatter: session.decimal)
                .font(Font.largeTitle.bold().monospacedDigit())
            Text(" Map Squares")
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)
            Spacer()
        }
        .padding(.leading)
        Text(NSNumber(value: Double(tiles.count) / Metrics.map.tiles), formatter: session.percentil)
            .font(Font.callout.monospacedDigit())
            .foregroundColor(.secondary)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            .padding(.leading)
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.secondary)
                .frame(height: 1)
            Map(session: $session, tiles: tiles)
            Rectangle()
                .fill(Color.secondary)
                .frame(height: 1)
                .onAppear {
                    session.location.enrollIfNeeded()
                }
        }
    }
}
