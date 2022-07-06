import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    let chart: Chart
    
    var body: some View {
        ScrollView {
            Explore(leaf: .init(squares: session.tiles.count))
            
            if chart.walks > 0 {
                Item(title: "Streak",
                     trend: nil,
                     average: heading(title: "Current")
                     + .streak(value: chart.streak.current),
                     max: heading(title: "Max")
                     + .streak(value: chart.streak.max),
                     total: .walks(value: chart.walks),
                     progress: .init(current: chart.streak.current,
                                     max: chart.streak.max))
            }
            
            if chart.duration.total > 0 {
                Item(title: "Time",
                     trend: chart.duration.trend,
                     average: heading(title: "Average")
                     + .duration(value: chart.duration.average),
                     max: heading(title: "Max")
                     + .duration(value: chart.duration.max),
                     total: .duration(value: chart.duration.total),
                     progress: .init(current: chart.duration.average,
                                     max: chart.duration.max))
            }
            
            if chart.steps.total > 0 {
                Item(title: "Steps",
                     trend: chart.steps.trend,
                     average: heading(title: "Average")
                     + .plain(value: chart.steps.average),
                     max: heading(title: "Max")
                     + .plain(value: chart.steps.max),
                     total: .plain(value: chart.steps.total),
                     progress: .init(current: chart.steps.average,
                                     max: chart.steps.max))
            }
            
            if chart.metres.total > 0 {
                Item(title: "Distance",
                     trend: chart.metres.trend,
                     average: heading(title: "Average")
                     + .metres(value: chart.metres.average,
                               fraction: true),
                     max: heading(title: "Max")
                     + .metres(value: chart.metres.max,
                               fraction: true),
                     total: .metres(value: chart.metres.total,
                                    fraction: false),
                     progress: .init(current: chart.metres.average,
                                     max: chart.metres.max))
            }
            
            if chart.calories.total > 0 {
                Item(title: "Calories",
                     trend: chart.calories.trend,
                     average: heading(title: "Average")
                     + .calories(value: chart.calories.average, caption: false),
                     max: heading(title: "Max")
                     + .calories(value: chart.calories.max, caption: false),
                     total: .calories(value: chart.calories.total, caption: false),
                     progress: .init(current: chart.calories.average,
                                     max: chart.calories.max))
            }
        }
    }
    
    private func heading(title: String) -> AttributedString {
        var string = AttributedString(title + " ")
        string.font = .footnote.weight(.medium)
        return string
    }
}
