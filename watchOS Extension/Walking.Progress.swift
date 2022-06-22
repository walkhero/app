import SwiftUI

extension Walking {
    struct Progress: View {
        @ObservedObject var session: Session
        @ObservedObject var walker: Walker
        @State private var limit = false
        
        var body: some View {
            ScrollView {
                Top(session: session)
                
                if limit {
                    Streak(streak: session.chart.streak.current, walks: session.chart.walks)
                }
                
                Explore(walker: walker, limit: limit)
                
                Item(value: .steps(value: walker.steps),
                     limit: limit && session.chart.steps.max > 0
                     ? .steps(value: session.chart.steps.max)
                     : nil,
                     indicator: .init(current: walker.steps, max: session.chart.steps.max))
                
                Item(value: .metres(value: walker.metres, digits: 3),
                     limit: limit && session.chart.metres.max > 0
                     ? .metres(value: session.chart.metres.max, digits: 1)
                     : nil,
                     indicator: .init(current: walker.metres, max: session.chart.metres.max))
                
                Item(value: .calories(value: walker.calories),
                     limit: limit && session.chart.calories.max > 0
                     ? .calories(value: session.chart.calories.max)
                     : nil,
                     indicator: .init(current: walker.calories, max: session.chart.calories.max))
            }
            .animation(.easeInOut(duration: 0.4), value: limit)
            .onTapGesture {
                limit.toggle()
            }
        }
    }
}
