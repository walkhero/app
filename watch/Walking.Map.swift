import SwiftUI

extension Walking {
    struct Map: View {
        @Binding var session: Session
        let tiles: Int
        
        var body: some View {
            ZStack {
                Text("MAP")
                    .font(.footnote)
                    .padding([.leading, .top])
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                VStack {
                    Text(NSNumber(value: tiles), formatter: session.decimal)
                        .font(Font.title.bold())
                    Text("Map Squares")
                        .font(.callout)
                    Text(NSNumber(value: Double(tiles) / Metrics.map.tiles), formatter: session.percentil)
                        .font(Font.caption.monospacedDigit())
                        .foregroundColor(.secondary)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
