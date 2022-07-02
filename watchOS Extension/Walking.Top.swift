import SwiftUI

extension Walking {
    struct Top: View {
        let session: Session
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            TimelineView(.periodic(from: .now, by: phase == .active ? 1 : 5)) { time in
                VStack(spacing: 1) {
                    Indicator(current: .init(time.date.timestamp - session.walking),
                              max: session.chart.duration.max,
                              height: 12)
                    .frame(width: 56)
                    
                    if session.walking > 0 {
                        Text(.duration(start: session.walking, current: time.date))
                            .font(.system(size: 32, weight: .medium).monospacedDigit())
                            .lineLimit(1)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                    }
                }
            }
        }
    }
}
