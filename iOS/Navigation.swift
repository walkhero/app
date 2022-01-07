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
                .font(.largeTitle.monospacedDigit())
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
            
            if updated == nil || !Calendar.current.isDateInToday(updated!.start) {
                Label("No walk today yet", systemImage: "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding()
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Bar()
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Header(status: status)
        }
        .onReceive(cloud) {
            streak = $0.calendar.streak
            updated = $0.updated
        }
    }
}
