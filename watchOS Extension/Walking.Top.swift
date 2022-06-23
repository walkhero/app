import SwiftUI

extension Walking {
    struct Top: View {
        let session: Session
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            TimelineView(.animation(minimumInterval: 1, paused: phase != .active)) { time in
                HStack(alignment: .firstTextBaseline) {
                    if session.walking > 0 {
                        Text(.duration(start: session.walking, current: time.date))
                            .font(.title.weight(.medium).monospacedDigit())
                            .lineLimit(1)
                            .fixedSize()
                    }
                    
                    Indicator(current: .init(time.date.timestamp - session.walking),
                             max: session.chart.duration.max)
                }
            }
        }
    }
}
