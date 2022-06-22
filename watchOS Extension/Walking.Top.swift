import SwiftUI

extension Walking {
    struct Top: View {
        let session: Session
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            TimelineView(.animation(minimumInterval: 1, paused: phase != .active)) { time in
                Text(.duration(start: session.walking, current: time.date))
                    .font(.title2.weight(.medium).monospacedDigit())
                    .lineLimit(1)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .modifier(Indicator(current: .init(time.date.timestamp - session.walking),
                                        max: session.chart.duration.max))
            }
        }
    }
}
