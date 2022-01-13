import SwiftUI
import Hero

struct Stats: View {
    @State private var streak = Streak.zero
    @State private var squares = 0
    @State private var duration = Chart.zero
    @State private var steps = Chart.zero
    @State private var metres = Chart.zero
    @State private var updated: DateInterval?
    private let world = pow(Double(4), 20)
    
    var body: some View {
        List {
            Today(updated: updated)
            
            Section {
                Header(title: "Streak")
                Item(text: .init(streak.current, format: .number), title: "Current days")
                Item(text: .init(streak.max, format: .number), title: "Max days")
            }
            
            Section {
                Header(title: "Duration")
                Item(text: .init(.init(timeIntervalSinceNow: .init(-duration.average)) ..< .now,
                                 format: .timeDuration), title: "Average")
                Item(text: .init(.init(timeIntervalSinceNow: .init(-duration.max)) ..< .now,
                                 format: .timeDuration), title: "Max")
                Item(text: .init(.init(timeIntervalSinceNow: .init(-duration.total)) ..< .now,
                                 format: .timeDuration), title: "Total")
            }
            .headerProminence(.increased)
            .allowsHitTesting(false)
            
            Section {
                Header(title: "Steps")
                Item(text: .init(steps.average, format: .number), title: "Average")
                Item(text: .init(steps.max, format: .number), title: "Max")
                Item(text: .init(steps.total, format: .number), title: "Total")
            }
            
            Section {
                Header(title: "Distance")
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
            
            Section {
                Header(title: "Map")
                Item(text: .init(squares, format: .number), title: "Squares")
                Item(text: .init(Double(squares) / world,
                                 format: .percent.precision(.significantDigits(4))), title: "World")
            }
        }
        .onReceive(cloud) {
            updated = $0.updated
            streak = $0.calendar.streak
            squares = $0.tiles.count
            duration = $0.duration
            steps = $0.steps
            metres = $0.metres
        }
    }
}
