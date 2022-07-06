import Foundation
import Hero

final class Session: ObservableObject {
    @Published var loaded = false
    @Published var walking = UInt32()
    @Published var tiles = Set<Squares.Item>()
    @Published var chart: Chart?
    @Published var summary: Summary?
    @Published var achievement: Leaf?
    
    @MainActor func update(chart: Chart, tiles: Set<Squares.Item>) {
        self.chart = chart
        self.tiles = tiles
    }
}
