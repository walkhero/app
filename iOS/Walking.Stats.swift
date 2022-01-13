import SwiftUI
import Hero

extension Walking {
    struct Stats: View {
        @ObservedObject var status: Status
        let steps: Int
        let metres: Int
        @State private var tiles = Set<Tile>([])
        
        var body: some View {
            HStack(spacing: 0) {
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
                Item(text: .init(status
                                    .tiles
                                    .subtracting(tiles)
                                    .count, format: .number),
                     caption: tiles.isEmpty ? nil : .init(tiles.count, format: .number),
                     title: "Squares")
            }
            .onReceive(cloud) {
                tiles = $0.tiles
            }
        }
    }
}
