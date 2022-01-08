import SwiftUI

extension GraphicsContext {
    mutating func draw(clock: Int, center: CGPoint, side: CGFloat) {
//        translateBy(x: center.x, y: center.y)
//        rotate(by: .degrees(-180))
//        translateBy(x: -center.x, y: -center.y)

        (0 ..< 120)
            .forEach { index in
                translateBy(x: center.x, y: center.y)
                rotate(by: .degrees(3))
                translateBy(x: -center.x, y: -center.y)
                
                if abs(index - clock) != 1 && !(clock == 119 && index == 0) && !(clock == 0 && index == 119) {
                    stroke(.init {
                        $0.move(to: .init(x: center.x,
                                          y: center.y - side))
                        $0.addLine(to: .init(x: center.x,
                                             y: center.y - side + (index == clock
                                                                   ? 13
                                                                   : index % 2 == 0
                                                                       ? 3
                                                                       : 5)))
                    }, with: .color(.pink), style: .init(lineWidth: index == clock
                                                         ? 2.5
                                                         : index < clock
                                                         ? 1.5
                                                             : 0.5, lineCap: .round))
                }
            }
    }
}
