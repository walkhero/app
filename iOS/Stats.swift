import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Explore(leaf: .init(squares: session.tiles.count))
                
//                Item(value: .streak(value: session.chart.streak.current),
//                     item: session.chart.streak)
                
                Item(value: .walks(value: session.chart.walks),
                     item: session.chart.duration)
                
                Item(value: .steps(value: session.chart.steps.total),
                     item: session.chart.steps)
                
                Item(value: .metres(value: session.chart.metres.total, digits: 4),
                     item: session.chart.metres)
                
                Item(value: .calories(value: session.chart.calories.total, digits: 4),
                     item: session.chart.calories)
            }
            .padding(.vertical, 20)
        }
    }
}
