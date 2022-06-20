import SwiftUI

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                achievements
                health
            }
        }
    }
    
    @ViewBuilder private var achievements: some View {
        title(value: "Achievements")
        
        Explore(leaf: .init(squares: session.tiles.count))

        Item(value: .streak(value: session.chart.streak.current),
             trend: nil)

        Item(value: .walks(value: session.chart.walks),
             trend: nil)
    }
    
    @ViewBuilder private var health: some View {
        title(value: "Time")
        
        Item(value: .duration(value: session.chart.duration.total),
             trend: nil)
        
        title(value: "Health")
        
        Item(value: .steps(value: session.chart.steps.total),
             trend: session.chart.steps.trend)
        
        Item(value: .metres(value: session.chart.metres.total, digits: 0),
             trend: session.chart.metres.trend)
        
        Item(value: .calories(value: session.chart.calories.total, digits: 0),
             trend: session.chart.calories.trend)
    }
    
    private func title(value: String) -> some View {
        Text(value)
            .font(.callout.weight(.medium))
            .foregroundColor(.accentColor)
            .padding([.leading, .top])
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
    }
}
