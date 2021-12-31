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
                } header: {
                    if !calendar.isEmpty {
                        Navigation(index: $index, calendar: calendar)
                            .textCase(nil)
                    }
                }
                
                if !calendar.isEmpty {
                    Section {
                        Month(days: calendar[index],
                              previous: index > 0 && calendar[index - 1].items.last!.last!.hit,
                              next: index < calendar.count - 1 && calendar[index + 1].items.first!.first!.hit)
                    }
                    .allowsHitTesting(false)
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
                .allowsHitTesting(false)
                
                Section("Streak") {
                    Text("Current")
                    Text("Max")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
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
