import SwiftUI
import Hero

private let world = pow(Double(4), 20)

struct Stats: View {
    @State private var chart = Chart.zero
    @StateObject private var game = Game()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Leaderboard(game: game)
                
                Today(updated: chart.updated)
                
                Section("Streak") {
                    Item(text: .init(chart.walks, format: .number), title: "Walks")
                    Item(text: .init(chart.streak.current, format: .number), title: "Current days")
                    Item(text: .init(chart.streak.max, format: .number), title: "Max days")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Duration") {
                    Trend(trend: chart.duration.trend,
                          text: .init(.init(timeIntervalSinceNow: .init(-chart.duration.average)) ..< .now,
                                      format: .timeDuration))
                    Item(text: .init(.init(timeIntervalSinceNow: .init(-chart.duration.max)) ..< .now,
                                     format: .timeDuration), title: "Max")
                    Item(text: .init(.init(timeIntervalSinceNow: .init(-chart.duration.total)) ..< .now,
                                     format: .timeDuration), title: "Total")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Steps") {
                    Trend(trend: chart.steps.trend, text: .init(chart.steps.average, format: .number))
                    Item(text: .init(chart.steps.max, format: .number), title: "Max")
                    Item(text: .init(chart.steps.total, format: .number), title: "Total")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Distance") {
                    Trend(trend: chart.metres.trend, text: .init(.init(value: .init(chart.metres.average),
                                           unit: UnitLength.meters),
                                     format: .measurement(width: .abbreviated,
                                                          usage: .general,
                                                          numberFormatStyle: .number)))
                    Item(text: .init(.init(value: .init(chart.metres.max),
                                           unit: UnitLength.meters),
                                     format: .measurement(width: .abbreviated,
                                                          usage: .general,
                                                          numberFormatStyle: .number)), title: "Max")
                    Item(text: .init(.init(value: .init(chart.metres.total),
                                           unit: UnitLength.meters),
                                     format: .measurement(width: .abbreviated,
                                                          usage: .general,
                                                          numberFormatStyle: .number)), title: "Total")
                }
                .headerProminence(.increased)
                .allowsHitTesting(false)
                
                Section("Map") {
                    Item(text: .init(chart.squares, format: .number), title: "Squares")
                    Item(text: .init(Double(chart.squares) / world,
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
            chart = $0.chart
            
            game.submit(streak: chart.streak.max,
                        steps: chart.steps.max,
                        distance: chart.metres.max,
                        map: chart.squares)
        }
    }
}
