import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    @AppStorage("premium") private var premium = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if Defaults.froob {
                    if !premium {
                        Upgrade()
                    }
                }
                
                achievements
                health
            }
            .padding(.bottom, 50)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Main.Title(title: "Overview")  {
                EmptyView()
            }
        }
    }
    
    @ViewBuilder private var achievements: some View {
        title(value: "Achievements")
        
        Explore(leaf: .init(squares: session.tiles.count))
        
        Item(value: .streak(value: session.chart.streak.current)
             + .init(" ") + .walks(value: session.chart.walks),
             active: session.chart.walks > 0,
             content: Streak(streak: session.chart.streak, walks: session.chart.walks))
    }
    
    @ViewBuilder private var health: some View {
        title(value: "Time")
        
        Item(value: .duration(value: session.chart.duration.total),
             active: session.chart.duration.total > 0,
             content: Detail(title: "Time",
                             trend: session.chart.duration.trend,
                             average: .duration(value: session.chart.duration.average),
                             max: .duration(value: session.chart.duration.max),
                             total: .duration(value: session.chart.duration.total)))
        
        title(value: "Steps")
        
        Item(value: .steps(value: session.chart.steps.total),
             active: session.chart.steps.total > 0,
             content: Detail(title: "Steps",
                             trend: session.chart.steps.trend,
                             average: .steps(value: session.chart.steps.average),
                             max: .steps(value: session.chart.steps.max),
                             total: .steps(value: session.chart.steps.total)))
        
        title(value: "Distance")
        
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
        
        title(value: "Active calories")
        
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
    
    private func title(value: String) -> some View {
        Text(value)
            .font(.body.weight(.medium))
            .foregroundStyle(.tertiary)
            .padding(.leading, 20)
            .padding(.top, 25)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
    }
}
