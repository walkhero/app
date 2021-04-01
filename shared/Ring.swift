import SwiftUI

struct Ring: Shape {
    var percent: Double
    
    func path(in rect: CGRect) -> Path {
        .init {
            $0.addArc(
                center: .init(x: rect.width / 2, y: rect.height / 2),
                radius: min(rect.width, rect.height) / 2,
                startAngle: .init(degrees: -90),
                endAngle: .init(degrees: (360 * percent) - 90),
                clockwise: false)
        }
    }
    
    var animatableData: Double {
        get { percent }
        set { percent = newValue }
    }
}
