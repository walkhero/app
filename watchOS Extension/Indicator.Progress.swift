import SwiftUI

extension Indicator {
    struct Progress: Shape {
        var value: Double
        
        init(current: Int, max: Int) {
            value = max > 0 ? min(.init(current) / .init(max), 1) : 1
        }
        
        func path(in rect: CGRect) -> Path {
            .init {
                $0.addRect(.init(origin: .zero,
                                 size: .init(width: value * rect.width,
                                             height: rect.height)))
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
}
