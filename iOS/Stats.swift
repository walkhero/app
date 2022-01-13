import SwiftUI
import Hero

struct Stats: View {
    @State private var streak = Streak.zero
    @State private var squares = 0
    @State private var duration = Chart.zero
    @State private var steps = Chart.zero
    @State private var metres = Chart.zero
    @State private var updated: DateInterval?
    @StateObject private var game = Game()
    @Environment(\.dismiss) private var dismiss
    private let world = pow(Double(4), 20)
    
    var body: some View {
        NavigationView {
            List {
                Leaderboard(game: game)
                
                Today(updated: updated)
                
                Section("Streak") {
                    Item(text: .init(streak.current, format: .number), title: "Current days")
                    Item(text: .init(streak.max, format: .number), title: "Max days")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Duration") {
                    Item(text: .init(.init(timeIntervalSinceNow: .init(-duration.average)) ..< .now,
                                     format: .timeDuration), title: "Average")
                    Item(text: .init(.init(timeIntervalSinceNow: .init(-duration.max)) ..< .now,
                                     format: .timeDuration), title: "Max")
                    Item(text: .init(.init(timeIntervalSinceNow: .init(-duration.total)) ..< .now,
                                     format: .timeDuration), title: "Total")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Steps") {
                    Item(text: .init(steps.average, format: .number), title: "Average")
                    Item(text: .init(steps.max, format: .number), title: "Max")
                    Item(text: .init(steps.total, format: .number), title: "Total")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Distance") {
                    Item(text: .init(.init(value: .init(metres.average),
                                           unit: UnitLength.meters),
                                     format: .measurement(width: .abbreviated,
                                                          usage: .general,
                                                          numberFormatStyle: .number)), title: "Average")
                    Item(text: .init(.init(value: .init(metres.max),
                                           unit: UnitLength.meters),
                                     format: .measurement(width: .abbreviated,
                                                          usage: .general,
                                                          numberFormatStyle: .number)), title: "Max")
                    Item(text: .init(.init(value: .init(metres.total),
                                           unit: UnitLength.meters),
                                     format: .measurement(width: .abbreviated,
                                                          usage: .general,
                                                          numberFormatStyle: .number)), title: "Total")
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
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        game.leaderboard()
                    } label: {
                        Text("Leaderboards")
                            .contentShape(Rectangle())
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onReceive(cloud) {
            updated = $0.updated
            streak = $0.calendar.streak
            squares = $0.tiles.count
            duration = $0.duration
            steps = $0.steps
            metres = $0.metres
            
            game.submit(streak: streak.max,
                        steps: steps.max,
                        distance: metres.max,
                        map: squares)
        }
    }
}
