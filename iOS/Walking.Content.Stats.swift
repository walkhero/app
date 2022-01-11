import SwiftUI
import Hero

extension Walking.Content {
    struct Stats: View {
        @ObservedObject var status: Status
        @State private var tiles = Set<Tile>([])
        
        var body: some View {
            HStack {
                Item(text: .init(status.steps, format: .number), title: "Steps")
                Item(text: .init(.init(value: .init(status.distance),
                                       unit: UnitLength.meters),
                                 format: .measurement(width: .abbreviated,
                                                      usage: .general,
                                                      numberFormatStyle: .number)), title: "Distance")
                Item(text: .init(status
                                    .tiles
                                    .subtracting(tiles)
                                    .count, format: .number), title: "Squares")
            }
            .onReceive(cloud) {
                tiles = $0.tiles
            }
        }
    }
}
