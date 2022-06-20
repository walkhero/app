import SwiftUI
import Hero

struct Walking: View {
    @ObservedObject var session: Session
    @StateObject private var walker = Walker()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
//                Explore(walker: walker)
//                
//                Streak(streak: session.chart.streak.current, walks: session.chart.walks)
//
//                Item(value: .steps(value: walker.steps),
//                     limit: session.chart.steps.max > 0 ? .steps(value: session.chart.steps.max) : nil,
//                     progress: .init(current: walker.steps, max: session.chart.steps.max))
//                
//                Item(value: .metres(value: walker.metres, digits: 3),
//                     limit: session.chart.metres.max > 0 ? .metres(value: session.chart.metres.max, digits: 1) : nil,
//                     progress: .init(current: walker.metres, max: session.chart.metres.max))
//                
//                Item(value: .calories(value: walker.calories, digits: 3),
//                     limit: session.chart.calories.max > 0 ? .calories(value: session.chart.calories.max, digits: 1) : nil,
//                     progress: .init(current: walker.calories, max: session.chart.calories.max))
            }
            .padding(.vertical, 20)
        }
        .onChange(of: session.tiles) {
            walker.tiles = $0
        }
        .task {
            walker.tiles = session.tiles
            await walker.start(date: .init(timestamp: session.walking))
        }
    }
}
