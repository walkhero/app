import SwiftUI
import Hero

struct Mapper: View {
    @Binding var session: Session
    let bottom: Bool
    @State private var follow = true
    
    var body: some View {
        HStack {
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(NSNumber(value: session.archive.tiles.count), formatter: session.decimal)
                        .font(.largeTitle.bold().monospacedDigit())
                    Text(" Map Squares")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 5)
                    Spacer()
                }
                .padding(.leading)
                Text(NSNumber(value: Double(session.archive.tiles.count) / Metrics.map.tiles), formatter: session.percentil)
                    .font(.callout.monospacedDigit())
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.leading)
            }
            Spacer()
            Button {
                follow.toggle()
            } label: {
                Image(systemName: follow ? "location.fill.viewfinder" : "location.slash.fill")
                    .font(follow ? .title : .title2)
                    .foregroundColor(follow ? .pink : .secondary)
                    .frame(width: 65, height: 40)
            }
        }
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.secondary)
                .frame(height: 1)
            Map(tiles: session.archive.tiles, follow: follow)
                .onAppear {
                    location.enrollIfNeeded()
                }
            if bottom {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(height: 1)
            }
        }
    }
}
