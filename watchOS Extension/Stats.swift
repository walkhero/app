import SwiftUI
import UserNotifications
import Hero

struct Stats: View {
    @State private var streak = Streak.zero
    @State private var updated: DateInterval?
    
    var body: some View {
        List {
            Section {
                Button {
                    
                } label: {
                    Text("Start a walk")
                }
                .buttonStyle(.borderedProminent)
            }
            .listRowBackground(Color.clear)
            
            Section("Today") {
                if updated == nil || !Calendar.current.isDateInToday(updated!.start) {
                    HStack {
                        Text("No walk today")
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                    }
                    .foregroundColor(.secondary)
                    .font(.footnote)
                } else {
                    HStack {
                        Image(systemName: "figure.walk")
                            .font(.title3.weight(.light))
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }
                
                if let updated = updated {
                    Text("Updated ")
                        .foregroundColor(.secondary)
                        .font(.caption2)
                    + Text(updated.end, format: .relative(presentation: .named))
                        .foregroundColor(.secondary)
                        .font(.caption2)
                }
            }
            .allowsHitTesting(false)
            
            Section("Streak") {
                HStack {
                    Text("Current")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                    Text(streak.current, format: .number)
                        .font(.footnote.monospacedDigit())
                }
                HStack {
                    Text("Max")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                    Text(streak.max, format: .number)
                        .font(.footnote.monospacedDigit())
                }
            }
            .allowsHitTesting(false)
        }
        .onReceive(cloud) {
            updated = $0.updated
            streak = $0.calendar.streak
        }
    }
}
