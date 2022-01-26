import SwiftUI

extension GraphicsContext {
#if os(iOS)
    mutating func ring(title: String, center: CGPoint, side: CGFloat, percent: Double, anchor: UnitPoint) {
        let origin = CGPoint(x: center.x - 100, y: center.y - side)
        draw(Text(title)
                .font(.caption2)
                .foregroundColor(.primary.opacity(0.55)),
             at: .init(x: origin.x - 7, y: origin.y),
             anchor: anchor)
        
        stroke(.init {
            $0.move(to: origin)
            $0.addArc(center: center,
                      radius: side,
                      startAngle: .degrees(-90),
                      endAngle: .degrees(270),
                      clockwise: false)
        },
               with: .color(.accentColor.opacity(0.07)),
               style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round))
        
        stroke(.init {
            $0.addArc(center: center,
                      radius: side,
                      startAngle: .degrees(-90),
                      endAngle: .degrees((360 * min(1, percent)) - 90),
                      clockwise: false)
        },
               with: .color(.accentColor),
               style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round))
    }
#else
    mutating func ring(center: CGPoint, side: CGFloat, percent: Double) {
        stroke(.init {
            $0.addArc(center: center,
                      radius: side,
                      startAngle: .degrees(-90),
                      endAngle: .degrees(270),
                      clockwise: false)
        },
               with: .color(.accentColor.opacity(0.2)),
               style: .init(lineWidth: 6, lineCap: .round, lineJoin: .round))
        
        stroke(.init {
            $0.addArc(center: center,
                      radius: side,
                      startAngle: .degrees(-90),
                      endAngle: .degrees((360 * min(1, percent)) - 90),
                      clockwise: false)
        },
               with: .color(.accentColor),
               style: .init(lineWidth: 6, lineCap: .round, lineJoin: .round))
    }
#endif
}
