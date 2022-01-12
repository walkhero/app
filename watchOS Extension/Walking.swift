import SwiftUI
import Hero

struct Walking: View {
    let started: Date
    
    var body: some View {
        TimelineView(.periodic(from: started, by: 0.25)) { time in
            Canvas { context, size in
                let duration = time.date.timeIntervalSince(started)
                let center = CGPoint(x: size.width / 2, y: (size.height / 2))
                
                context.draw(clock: .init(round(duration.truncatingRemainder(dividingBy: 60) * 2)),
                             center: center,
                             side: min(size.width, size.height) * 0.44,
                             color: .accentColor)
                
                context.draw(Text((started ..< .now).formatted(.timeDuration))
                                .font(duration < 60 ? .largeTitle.monospacedDigit() : .title2.monospacedDigit()),
                             at: center)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
