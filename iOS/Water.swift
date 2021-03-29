import SwiftUI

struct Water: Shape {
    var percent: Double
    
    func path(in rect: CGRect) -> Path {
        .init {
            let y =  rect.maxY - (rect.maxY * .init(percent))
            $0.move(to: .init(x: 0, y: y))
            $0.addCurve(to: .init(x: rect.maxX, y: y), control1: .init(x: rect.maxX * 0.4, y: y - random), control2: .init(x: rect.maxX * 0.6, y: y + random))
            $0.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            $0.addLine(to: .init(x: 0, y: rect.maxY))
            $0.closeSubpath()
        }
    }
    
    var animatableData: Double {
        get { percent }
        set { percent = newValue }
    }
    
    private var random: CGFloat {
        .random(in: 1 ..< 75)
    }
}
