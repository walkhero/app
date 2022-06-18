import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Explore(leaf: .init(squares: session.tiles.count))
                
                Item(value: .streak(value: session.chart.streak.current),
                     content: Streak(streak: session.chart.streak))
                
                Item(value: .walks(value: session.chart.walks),
                     content: Detail(title: "Duration",
                                     trend: session.chart.duration.trend,
                                     average: .duration(amount: session.chart.duration.average),
                                     max: .duration(amount: session.chart.duration.max),
                                     total: .duration(amount: session.chart.duration.total)))
//
//                Item(value: .steps(value: session.chart.steps.total),
//                     item: session.chart.steps)
//
//                Item(value: .metres(value: session.chart.metres.total, digits: 4),
//                     item: session.chart.metres)
//
//                Item(value: .calories(value: session.chart.calories.total, digits: 4),
//                     item: session.chart.calories)
            }
            .padding(.vertical, 20)
        }
    }
}
