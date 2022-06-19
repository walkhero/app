import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Explore(leaf: .init(squares: session.tiles.count))
                
                Item(value: .streak(value: session.chart.streak.current),
                     active: session.chart.walks > 0,
                     content: Streak(streak: session.chart.streak))
                
                Item(value: .walks(value: session.chart.walks),
                     active: session.chart.walks > 0,
                     content: Detail(title: "Duration",
                                     trend: session.chart.duration.trend,
                                     average: .duration(value: session.chart.duration.average),
                                     max: .duration(value: session.chart.duration.max),
                                     total: .duration(value: session.chart.duration.total)))
                
                Item(value: .steps(value: session.chart.steps.total),
                     active: session.chart.steps.total > 0,
                     content: Detail(title: "Steps",
                                     trend: session.chart.steps.trend,
                                     average: .steps(value: session.chart.steps.average),
                                     max: .steps(value: session.chart.steps.max),
                                     total: .steps(value: session.chart.steps.total)))
                
                Item(value: .metres(value: session.chart.metres.total, digits: 0),
                     active: session.chart.metres.total > 0,
                     content: Detail(title: "Distance",
                                     trend: session.chart.metres.trend,
                                     average: .metres(value: session.chart.metres.average,
                                                      digits: 3),
                                     max: .metres(value: session.chart.metres.max,
                                                 digits: 3),
                                     total: .metres(value: session.chart.metres.total,
                                                   digits: 1)))
                
                Item(value: .calories(value: session.chart.calories.total, digits: 0),
                     active: session.chart.calories.total > 0,
                     content: Detail(title: "Active calories",
                                     trend: session.chart.metres.trend,
                                     average: .calories(value: session.chart.calories.average,
                                                      digits: 3),
                                     max: .calories(value: session.chart.calories.max,
                                                 digits: 3),
                                     total: .calories(value: session.chart.calories.total,
                                                   digits: 1)))
            }
            .padding(.vertical, 20)
        }
    }
}
