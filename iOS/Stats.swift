import SwiftUI
import Hero

struct Stats: View {
    @State private var streak = Streak.zero
    @State private var squares = 0
    @State private var updated: DateInterval?
    @Environment(\.dismiss) private var dismiss
    private let world = pow(Double(4), 20)
    
    var body: some View {
        NavigationView {
            List {
                Section("Today") {
                    if updated == nil || !Calendar.current.isDateInToday(updated!.start) {
                        HStack {
                            Text("No walk today")
                                .font(.body)
                            Spacer()
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.title3)
                        }
                        .foregroundColor(.secondary)
                    } else {
                        HStack {
                            Image(systemName: "figure.walk")
                                .font(.title3.weight(.light))
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        .font(.title3)
                    }
                    
                    if let updated = updated {
                        Item(text: .init(updated.end,
                                         format: .relative(presentation: .named)),
                             title: "Updated")
                    }
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Streak") {
                    Item(text: .init(streak.current, format: .number), title: "Current")
                    Item(text: .init(streak.maximum, format: .number), title: "Max")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Map") {
                    Item(text: .init(squares, format: .number), title: "Squares")
                    Item(text: .init(Double(squares) / world,
                                     format: .percent.precision(.significantDigits(4))), title: "World")
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
            squares = $0.tiles.count
        }
    }
}
