import SwiftUI
import Combine
import Hero

extension Walking {
    struct Map: View {
        @Binding var session: Session
        @Binding var tiles: Set<Tile>
        @State private var count = 0
        
        var body: some View {
            VStack {
                Text("STREAK")
                    .font(.footnote)
                    .padding(.leading)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                Spacer()
                Text(NSNumber(value: count), formatter: session.decimal)
                    .font(Font.title2.bold())
                Text("Map Squares")
                    .font(.callout)
                Text(NSNumber(value: Double(count) / Metrics.map.tiles), formatter: session.percentil)
                    .font(Font.caption.monospacedDigit())
                    .foregroundColor(.secondary)
            }
            .onChange(of: tiles) {
                count = $0.count
            }
            .onAppear {
                count = tiles.count
            }
        }
    }
}
