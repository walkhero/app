import SwiftUI
import Hero

extension Walking {
    struct Stats: View {
        @ObservedObject var status: Status
        let steps: Int
        let metres: Int
        @State private var squares = Set<Squares.Item>()
        
        var body: some View {
            HStack(alignment: .bottom, spacing: 0) {
                Item(text: .init(status.steps, format: .number),
                     caption: steps > 0 ? .init(steps, format: .number) : nil,
                     title: "Steps")
                Item(text: .init(.init(value: .init(status.distance),
                                       unit: UnitLength.meters),
                                 format: .measurement(width: .abbreviated,
                                                      usage: .general,
                                                      numberFormatStyle: .number)),
                     caption: metres > 0
                     ? .init(.init(value: .init(metres),
                                   unit: UnitLength.meters),
                             format: .measurement(width: .abbreviated,
                                                  usage: .general,
                                                  numberFormatStyle: .number))
                     : nil,
                     title: "Distance")
                Item(text: .init(.init(value: .init(status.calories) / 1000.0,
                                       unit: UnitEnergy.kilocalories),
                                 format: .measurement(width: .abbreviated,
                                                      usage: .workout,
                                                      numberFormatStyle: .number)),
                     caption: .init(verbatim: "lol"),
                     title: "Calories")
                Item(text: .init(status
                                    .squares
                                    .items
                                    .subtracting(squares)
                                    .count, format: .number),
                     caption: squares.isEmpty ? nil : .init(squares.count, format: .number),
                     title: "Squares")
            }
            .onReceive(cloud) {
                squares = $0.squares
            }
        }
    }
}
