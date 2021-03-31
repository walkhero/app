import SwiftUI

struct Bar: Shape {
    let percent: CGFloat
    
    func path(in rect: CGRect) -> Path {
        .init {
            $0.move(to: .init(x: 0, y: rect.midY))
            $0.addLine(to: .init(x: rect.width * percent, y: rect.midY))
        }
    }
}
