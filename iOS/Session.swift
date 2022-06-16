import Foundation
import Hero

final class Sesssion: ObservableObject {
    @Published var loading = true
    @Published var walking = UInt32()
    @Published var chart = Chart.zero
    @Published var squares = Set<Squares.Item>()
    
    func duration(date: Date) -> AttributedString {
        var duration = AttributedString((.init(timestamp: walking) ..< date).formatted(.timeDuration))
        
        if Int(date.timeIntervalSince1970) % 2 == 1 {
            if let range = duration.range(of: ":") {
                duration[range].foregroundColor = .clear
            }
            if let range = duration.range(of: ":", options: [.backwards]) {
                duration[range].foregroundColor = .clear
            }
        }
        
        return duration
    }
}
