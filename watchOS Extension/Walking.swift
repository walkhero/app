import SwiftUI
import Hero

struct Walking: View {
    weak var status: Status!
    @Binding var summary: Summary?
    let started: Date
    @State private var squares = Set<Squares.Item>()
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
                  squares: squares,
                  steps: steps,
                  metres: metres)
            Controls(status: status,
                     summary: $summary,
                     started: started)
        }
        .onReceive(cloud) {
            squares = $0.squares
            duration = $0.duration.max
            steps = $0.steps.max
            metres = $0.metres.max
        }
    }
}
