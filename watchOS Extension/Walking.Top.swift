import SwiftUI
import Hero

extension Walking {
    struct Top: View {
        let chart: Chart
        let walking: UInt32
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            TimelineView(.periodic(from: .now, by: phase == .active ? 1 : 5)) { time in
                VStack(spacing: 1) {
                    Indicator(current: .init(time.date.timestamp - walking),
                              max: chart.duration.max,
                              height: 12)
                    .frame(width: 56)
                    
                    if walking > 0 {
                        Text(.duration(start: walking, current: time.date))
                            .font(.system(size: 32, weight: .medium).monospacedDigit())
                            .lineLimit(1)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                    }
                }
            }
        }
    }
}
