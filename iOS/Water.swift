import SwiftUI

struct Water: Shape {
    var percent: Double
    let a: CGFloat
    let b: CGFloat
    
    func path(in rect: CGRect) -> Path {
        .init {
            let y =  rect.maxY - (rect.maxY * .init(percent))
            $0.move(to: .init(x: 0, y: y))
            $0.addCurve(to: .init(x: rect.maxX, y: y), control1: .init(x: rect.maxX * 0.4, y: y - a), control2: .init(x: rect.maxX * 0.6, y: y + b))
            $0.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            $0.addLine(to: .init(x: 0, y: rect.maxY))
            $0.closeSubpath()
        }
    }
    
    var animatableData: Double {
        get { percent }
        set { percent = newValue }
    }
}
