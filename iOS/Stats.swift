import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    let chart: Chart
    @AppStorage("premium") private var premium = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Spacer()
                    .frame(height: 5)
                
                Walked(updated: chart.updated)
                
                if Defaults.froob {
                    if !premium {
                        Upgrade()
                    }
                }
                
                achievements
                health
            }
            .padding(.bottom, 40)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Main.Title(title: "Overview")  {
                if let updated = chart.updated?.start,
                    Calendar.global.isDateInToday(updated) {
                    Text("Walk today")
                        .font(.footnote.weight(.medium))
                        .foregroundColor(.accentColor)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.accentColor)
                        .padding(.trailing)
                } else {
                    Text("No walk today")
                        .font(.footnote.weight(.medium))
                        .foregroundColor(.pink)
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 22, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.pink)
                        .padding(.trailing)
                }
            }
        }
    }
    
    @ViewBuilder private var achievements: some View {
        Explore(leaf: .init(squares: session.tiles.count))
        
        Item(title: nil,
             value: .streak(value: chart.streak.current)
                     + .init("  ")
                     + .walks(value: chart.walks),
             content: chart.walks > 0
             ? .init(title: "Streak",
                     trend: nil,
                     average: heading(title: "Current")
                             + .streak(value: chart.streak.current),
                     max: heading(title: "Max")
                             + .streak(value: chart.streak.max),
                     total: .walks(value: chart.walks),
                     progress: .init(current: chart.streak.current,
                                        max: chart.streak.max))
             : nil)
    }
    
    @ViewBuilder private var health: some View {
        Item(title: "Time",
             value: .duration(value: chart.duration.total),
             content: chart.duration.total > 0
             ? .init(title: "Time",
                     trend: chart.duration.trend,
                     average: heading(title: "Average")
                         + .duration(value: chart.duration.average),
                     max: heading(title: "Max")
                         + .duration(value: chart.duration.max),
                     total: .duration(value: chart.duration.total),
                     progress: .init(current: chart.duration.average,
                                     max: chart.duration.max))
             : nil)
        
        Item(title: "Steps",
             value: .plain(value: chart.duration.total),
             content: chart.steps.total > 0
             ? .init(title: "Steps",
                     trend: chart.steps.trend,
                     average: heading(title: "Average")
                         + .plain(value: chart.steps.average),
                     max: heading(title: "Max")
                         + .plain(value: chart.steps.max),
                     total: .plain(value: chart.steps.total),
                     progress: .init(current: chart.steps.average,
                                     max: chart.steps.max))
             : nil)
        
        Item(title: "Distance",
             value: .metres(value: chart.metres.total, fraction: false),
             content: chart.metres.total > 0
             ? .init(title: "Distance",
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
             : nil)
        
        Item(title: "Calories",
             value: .calories(value: chart.calories.total, caption: false),
             content: chart.calories.total > 0
             ? .init(title: "Calories",
                     trend: chart.calories.trend,
                     average: heading(title: "Average")
                         + .calories(value: chart.calories.average, caption: false),
                     max: heading(title: "Max")
                         + .calories(value: chart.calories.max, caption: false),
                     total: .calories(value: chart.calories.total, caption: false),
                     progress: .init(current: chart.calories.average,
                                     max: chart.calories.max))
             : nil)
    }
    
    private func heading(title: String) -> AttributedString {
        var string = AttributedString(title + " ")
        string.font = .body.weight(.medium)
        return string
    }
}
