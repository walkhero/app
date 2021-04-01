import SwiftUI
import Combine
import Hero

extension Walking {
    struct Map: View {
        @Binding var session: Session
        let tiles: Int
        
        var body: some View {
            VStack {
                Text("STREAK")
                    .font(.footnote)
                    .padding(.leading)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                Spacer()
                Text(NSNumber(value: tiles), formatter: session.decimal)
                    .font(Font.title2.bold())
                Text("Map Squares")
                    .font(.callout)
                Text(NSNumber(value: Double(tiles) / Metrics.map.tiles), formatter: session.percentil)
                    .font(Font.caption.monospacedDigit())
                    .foregroundColor(.secondary)
            }
        }
    }
}
