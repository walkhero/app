import Foundation
import Hero

final class Session: ObservableObject {
    @Published var loading = true
    @Published var walking = UInt32()
    @Published var chart = Chart.zero
    @Published var tiles = Set<Squares.Item>()
    @Published var summary: Summary?
    
    @MainActor func update(chart: Chart, tiles: Set<Squares.Item>) {
        self.chart = chart
        self.tiles = tiles
        
        guard loading else { return }
        loading = false
    }
}
