import SwiftUI

extension GraphicsContext {
    mutating func draw(clock: Int, center: CGPoint, side: CGFloat, color: Color) {
        (0 ..< 121)
            .forEach { index in
                translateBy(x: center.x, y: center.y)
                rotate(by: .degrees(3))
                translateBy(x: -center.x, y: -center.y)
                
                if abs(index - clock) != 1 && !(clock == 120 && index == 0) && !(clock == 0 && index == 120) {
                    stroke(.init {
                        $0.move(to: .init(x: center.x,
                                          y: center.y - side))
                        $0.addLine(to: .init(x: center.x,
                                             y: center.y - side + (index == clock
                                                                   ? 0
                                                                   : index % 2 == 0
                                                                       ? 5
                                                                       : 8)))
                    }, with: .color(color), style: .init(lineWidth: index == clock
                                                         ? 10
                                                         : index < clock
                                                         ? 1.5
                                                             : 0.5, lineCap: .round))
                }
            }
    }
}
