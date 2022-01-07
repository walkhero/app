import SwiftUI
import Hero

struct Stats: View {
    @State private var streak = Streak.zero
    @State private var updated: DateInterval?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
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
            .navigationTitle("Stats")
            .navigationBarTitleDisplayMode(.large)
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
            updated = $0.updated
            streak = $0.calendar.streak
        }
    }
}
