import SwiftUI

extension Walking {
    struct Map: View {
        @Binding var session: Session
        
        var body: some View {
            ZStack {
                Text("MAP")
                    .font(.footnote)
                    .padding([.leading, .top])
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                VStack(alignment: .leading) {
                    Text(NSNumber(value: session.archive.tiles.count), formatter: session.decimal)
                        .font(.title.bold().monospacedDigit())
                    Text("Map Squares")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text(NSNumber(value: Double(session.archive.tiles.count) / Metrics.map.tiles), formatter: session.percentil)
                        .font(.callout.monospacedDigit())
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .padding(.leading)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
