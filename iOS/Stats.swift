import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    @AppStorage("premium") private var premium = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Spacer()
                    .frame(height: 5)
                
                Walked(updated: session.chart.updated)
                
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
                if let updated = session.chart.updated?.start,
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
             value: .streak(value: session.chart.streak.current)
                     + .init("  ")
                     + .walks(value: session.chart.walks),
             content: session.chart.walks > 0
             ? .init(title: "Streak",
                     trend: nil,
                     average: heading(title: "Current")
                             + .streak(value: session.chart.streak.current),
                     max: heading(title: "Max")
                             + .streak(value: session.chart.streak.max),
                     total: .walks(value: session.chart.walks),
                     progress: .init(current: session.chart.streak.current,
                                        max: session.chart.streak.max))
             : nil)
    }
    
    @ViewBuilder private var health: some View {
        Item(title: "Time",
             value: .duration(value: session.chart.duration.total),
             content: session.chart.duration.total > 0
             ? .init(title: "Time",
                     trend: session.chart.duration.trend,
                     average: heading(title: "Average")
                         + .duration(value: session.chart.duration.average),
                     max: heading(title: "Max")
                         + .duration(value: session.chart.duration.max),
                     total: .duration(value: session.chart.duration.total),
                     progress: .init(current: session.chart.duration.average,
                                     max: session.chart.duration.max))
             : nil)
        
        Item(title: "Steps",
             value: .plain(value: session.chart.duration.total),
             content: session.chart.steps.total > 0
             ? .init(title: "Steps",
                     trend: session.chart.steps.trend,
                     average: heading(title: "Average")
                         + .plain(value: session.chart.steps.average),
                     max: heading(title: "Max")
                         + .plain(value: session.chart.steps.max),
                     total: .plain(value: session.chart.steps.total),
                     progress: .init(current: session.chart.steps.average,
                                     max: session.chart.steps.max))
             : nil)
        
        Item(title: "Distance",
             value: .metres(value: session.chart.metres.total, fraction: false),
             content: session.chart.metres.total > 0
             ? .init(title: "Distance",
                     trend: session.chart.metres.trend,
                     average: heading(title: "Average")
                         + .metres(value: session.chart.metres.average,
                                   fraction: true),
                     max: heading(title: "Max")
                         + .metres(value: session.chart.metres.max,
                                   fraction: true),
                     total: .metres(value: session.chart.metres.total,
                                    fraction: false),
                     progress: .init(current: session.chart.metres.average,
                                     max: session.chart.metres.max))
             : nil)
        
        Item(title: "Calories",
             value: .calories(value: session.chart.calories.total, caption: false),
             content: session.chart.calories.total > 0
             ? .init(title: "Calories",
                     trend: session.chart.calories.trend,
                     average: heading(title: "Average")
                         + .calories(value: session.chart.calories.average, caption: false),
                     max: heading(title: "Max")
                         + .calories(value: session.chart.calories.max, caption: false),
                     total: .calories(value: session.chart.calories.total, caption: false),
                     progress: .init(current: session.chart.calories.average,
                                     max: session.chart.calories.max))
             : nil)
    }
    
    private func heading(title: String) -> AttributedString {
        var string = AttributedString(title + " ")
        string.font = .body.weight(.medium)
        return string
    }
}
