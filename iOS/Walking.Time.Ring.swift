import SwiftUI

extension Walking.Time {
    struct Ring: View {
        let indicator: Int
        let center: CGPoint
        
        var body: some View {
            ForEach(0 ..< 60) { index in
                if abs(index - indicator) != 1 && !(indicator == 59 && index == 0) && !(indicator == 0 && index == 59) {
                    Path {
                        $0.move(to: .init(x: center.x, y: center.y))
                        $0.addLine(to: .init(x: center.x, y: center.y + (index == indicator
                                                                            ? 15
                                                                            : index % 2 == 0
                                                                                ? 5
                                                                                : 12)))
                    }
                    .stroke(Color.accentColor, style: .init(lineWidth: index == indicator
                                                                ? 10
                                                                : index < indicator
                                                                    ? 3
                                                                    : 1, lineCap: .round))
                    .rotationEffect(.degrees(.init(index * 6)))
                }
            }
        }
    }
}
