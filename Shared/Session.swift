import Foundation
import Hero

final class Session: ObservableObject {
    @Published var loading = Int()
    @Published var walking = UInt32()
    @Published var chart = Chart.zero
    @Published var tiles = Set<Squares.Item>()
    @Published var summary: Summary?
    @Published var achievement: Leaf?
    
    @MainActor func update(chart: Chart, tiles: Set<Squares.Item>) {
        self.chart = chart
        self.tiles = tiles
        
        guard loading < 2 else { return }
        loading += 1
    }
}
