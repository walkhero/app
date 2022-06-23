import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            Explore(leaf: .init(squares: session.tiles.count))
            
            if session.chart.walks > 0 {
                Item(title: "Streak",
                     trend: nil,
                     average: heading(title: "Current")
                     + .streak(value: session.chart.streak.current),
                     max: heading(title: "Max")
                     + .streak(value: session.chart.streak.max),
                     total: .walks(value: session.chart.walks),
                     progress: .init(current: session.chart.streak.current,
                                     max: session.chart.streak.max))
            }
            
            if session.chart.duration.total > 0 {
                Item(title: "Time",
                     trend: session.chart.duration.trend,
                     average: heading(title: "Average")
                     + .duration(value: session.chart.duration.average),
                     max: heading(title: "Max")
                     + .duration(value: session.chart.duration.max),
                     total: .duration(value: session.chart.duration.total),
                     progress: .init(current: session.chart.duration.average,
                                     max: session.chart.duration.max))
            }
            
            if session.chart.steps.total > 0 {
                Item(title: "Steps",
                     trend: session.chart.steps.trend,
                     average: heading(title: "Average")
                     + .plain(value: session.chart.steps.average),
                     max: heading(title: "Max")
                     + .plain(value: session.chart.steps.max),
                     total: .plain(value: session.chart.steps.total),
                     progress: .init(current: session.chart.steps.average,
                                     max: session.chart.steps.max))
            }
            
            if session.chart.metres.total > 0 {
                Item(title: "Distance",
                     trend: session.chart.metres.trend,
                     average: heading(title: "Average")
                     + .metres(value: session.chart.metres.average,
                               digits: 3),
                     max: heading(title: "Max")
                     + .metres(value: session.chart.metres.max,
                               digits: 3),
                     total: .metres(value: session.chart.metres.total,
                                    digits: 0),
                     progress: .init(current: session.chart.metres.average,
                                     max: session.chart.metres.max))
            }
            
            if session.chart.calories.total > 0 {
                Item(title: "Calories",
                     trend: session.chart.calories.trend,
                     average: heading(title: "Average")
                     + .plain(value: session.chart.calories.average),
                     max: heading(title: "Max")
                     + .plain(value: session.chart.calories.max),
                     total: .plain(value: session.chart.calories.total),
                     progress: .init(current: session.chart.calories.average,
                                     max: session.chart.calories.max))
            }
        }
    }
    
    private func heading(title: String) -> AttributedString {
        var string = AttributedString(title + " ")
        string.font = .footnote.weight(.medium)
        return string
    }
}
