import SwiftUI
import Hero

struct Ephemeris: View {
    @State private var calendar = [Days]()
    @State private var streak = Streak.zero
    @State private var updated: DateInterval?
    @State private var index = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Week()
                    if !calendar.isEmpty {
                        Month(days: calendar[index],
                              previous: index > 0 && calendar[index - 1].items.last!.last!.hit,
                              next: index < calendar.count - 1 && calendar[index + 1].items.first!.first!.hit)
                    }
                } header: {
                    if !calendar.isEmpty {
                        Navigation(index: $index, calendar: calendar)
                    }
                }
                
                Section("Today") {
                    Text("Haven't walked today")
                    if let updated = updated {
                        Text("Updated ")
                            .foregroundColor(.secondary)
                            .font(.caption2)
                        + Text(updated.end, format: .relative(presentation: .named))
                            .foregroundColor(.secondary)
                            .font(.caption2)
                    }
                }
                .headerProminence(.increased)
                
                Section("Streak") {
                    Text("Current")
                    Text("Max")
                }
                .headerProminence(.increased)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onReceive(cloud) {
            calendar = $0.calendar
            updated = $0.updated
            streak = calendar.streak
            index = calendar.count - 1
        }
    }
}
