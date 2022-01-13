import SwiftUI
import Hero

extension Walking {
    struct Stats: View {
        @ObservedObject var status: Status
        let tiles: Set<Tile>
        let steps: Int
        let metres: Int
        
        var body: some View {
            ScrollView {
                Item(text: .init(status.steps, format: .number),
                     caption: .init(steps, format: .number),
                     title: "Steps",
                     subtitle: "Max ")
                
                Item(text: .init(.init(value: .init(status.distance),
                                       unit: UnitLength.meters),
                                 format: .measurement(width: .abbreviated,
                                                      usage: .general,
                                                      numberFormatStyle: .number)),
                     caption: .init(.init(value: .init(metres),
                                          unit: UnitLength.meters),
                                    format: .measurement(width: .abbreviated,
                                                         usage: .general,
                                                         numberFormatStyle: .number)),
                     title: "Distance",
                     subtitle: "Max ")
                
                Item(text: .init(status
                                    .tiles
                                    .subtracting(tiles)
                                    .count, format: .number),
                     caption: .init(tiles.count, format: .number),
                     title: "Squares",
                     subtitle: "Total ")
            }
        }
    }
}
