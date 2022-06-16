import SwiftUI

extension Walking {
    struct Duration: View {
        let session: Sesssion
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            TimelineView(.animation(minimumInterval: 1, paused: phase != .active)) { time in
                Text(session.duration(date: time.date))
                    .font(.system(size: 24, weight: .regular).monospacedDigit())
            }
        }
    }
}
