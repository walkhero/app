import SwiftUI

struct Progress: Shape {
    var value: Double
    
    init(current: Int, max: Int) {
        value = max > 0 ? min(.init(current) / .init(max), 1) : 1
    }

    func path(in rect: CGRect) -> Path {
        .init {
            $0.move(to: .init(x: 0, y: rect.height / 2))
            $0.addLine(to: .init(x: value * rect.width, y: rect.height / 2))
        }
    }

    var animatableData: Double {
        get {
            value
        }
        set {
            value = newValue
        }
    }
}
