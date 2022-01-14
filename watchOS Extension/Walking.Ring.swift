import SwiftUI

extension Walking {
    struct Ring: View {
        @ObservedObject var status: Status
        let started: Date
        let duration: Int
        let steps: Int
        let metres: Int
        
        var body: some View {
            TimelineView(.periodic(from: started, by: 0.5)) { time in
                Canvas { context, size in
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    let side = min(size.width, size.height) * 0.44
                    var y = 10.0
                    
                    if duration > 0 {
                        context.draw(Text("duration")
                                        .font(.caption2.weight(.light))
                                        .foregroundColor(.primary.opacity(0.3)),
                                     at: .init(x: 10, y: y), anchor: .topLeading)
                        y += 16
                    }
                    
                    if steps > 0 {
                        context.draw(Text("steps")
                                        .font(.caption2.weight(.light))
                                        .foregroundColor(.primary.opacity(0.3)),
                                     at: .init(x: 10, y: y), anchor: .topLeading)
                        y += 16
                    }
                    
                    if metres > 0 {
                        context.draw(Text("distance")
                                        .font(.caption2.weight(.light))
                                        .foregroundColor(.primary.opacity(0.3)),
                                     at: .init(x: 10, y: y), anchor: .topLeading)
                    }
                    
                    if duration > 0 {
                        context.ring(center: center,
                                     side: side,
                                     percent: (Date.now.timeIntervalSince1970 - started.timeIntervalSince1970) / .init(duration))
                        
                        context.draw(Text(.init(timeIntervalSinceNow: .init(-duration)) ..< .now, format: .timeDuration)
                                        .font(.caption2.monospacedDigit())
                                        .fontWeight(.light)
                                        .foregroundColor(.primary.opacity(0.4)),
                                     at: .init(x: center.x, y: center.y + 14))
                    }
                    
                    if steps > 0 {
                        context.ring(center: center,
                                     side: side - 9,
                                     percent: Double(status.steps) / .init(steps))
                    }
                    
                    if metres > 0 {
                        context.ring(center: center,
                                     side: side - 18,
                                     percent: Double(status.distance) / .init(metres))
                    }
                    
                    if duration == 0 && steps == 0 && metres == 0 {
                        context.ring(center: center,
                                     side: side,
                                     percent: 1)
                    }
                    
                    context.draw(Text(started ..< .now, format: .timeDuration)
                                    .font(.title3.monospacedDigit()),
                                 at: .init(x: center.x, y: center.y - 3))
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
