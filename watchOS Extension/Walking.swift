import SwiftUI
import Hero

struct Walking: View {
    weak var status: Status!
    @Binding var finish: Finish?
    let started: Date
    @State private var tiles = Set<Tile>()
    @State private var duration = 0
    @State private var steps = 0
    @State private var metres = 0
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Ring(status: status,
                 started: started,
                 duration: duration,
                 steps: steps,
                 metres: metres)
            Stats(status: status,
                  tiles: tiles,
                  steps: steps,
                  metres: metres)
            Controls(status: status,
                     finish: $finish,
                     started: started)
        }
        .onReceive(cloud) {
            tiles = $0.tiles
            duration = $0.duration.max
            steps = $0.steps.max
            metres = $0.metres.max
        }
    }
}
