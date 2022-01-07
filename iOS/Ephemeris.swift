import SwiftUI
import Hero

struct Ephemeris: View {
    @State private var calendar = [Days]()
    @State private var streak = Streak.zero
    @State private var updated: DateInterval?
    @State private var index = 0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                if !calendar.isEmpty {
                    Section {
                        Navigation(index: $index, calendar: calendar)
                            .textCase(nil)
                        Week()
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                    .listRowSeparator(.hidden)
                    
                    Section {
                        Month(days: calendar[index],
                              previous: index > 0 && calendar[index - 1].items.last!.last!.hit,
                              next: index < calendar.count - 1 && calendar[index + 1].items.first!.first!.hit)
                    }
                    .allowsHitTesting(false)
                }
                
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
                .headerProminence(.increased)
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
                        Text(streak.maximum, format: .number)
                            .font(.footnote.monospacedDigit())
                    }
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.callout.weight(.medium))
                            .padding(.leading)
                            .frame(height: 34)
                            .contentShape(Rectangle())
                            .allowsHitTesting(false)
                    }
                }
            }
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
