import Foundation
import Hero

final class Session: ObservableObject {
    @Published var loading = true
    @Published var walking = UInt32()
    @Published var chart = Chart.zero
    
    @MainActor func update(chart: Chart) {
        self.chart = chart
    }
}
