import SwiftUI
import Hero

struct Navigation: View {
    let status: Status
    @State private var streak = Streak.zero
    @State private var updated: DateInterval?
    
    var body: some View {
        VStack {
            Geo()
            Spacer()
            Text(streak.current, format: .number)
                .font(.largeTitle.monospaced())
            Text("Streak")
                .font(.callout)
                .foregroundColor(.secondary)
            if let updated = updated {
                Text("Updated ")
                    .foregroundColor(.secondary)
                    .font(.caption2)
                + Text(updated.end, format: .relative(presentation: .named))
                    .foregroundColor(.secondary)
                    .font(.caption2)
            }
            Spacer()
            Label("You haven't walked today", systemImage: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.footnote)
                .foregroundColor(.pink)
                .imageScale(.large)
            Spacer()
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Bar()
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Header(status: status)
        }
        .onReceive(cloud) {
            streak = $0.streak
            updated = $0.updated
        }
    }
}
