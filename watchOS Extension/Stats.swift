import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            achievements
            time
            steps
            distance
            calories
        }
    }
    
    @ViewBuilder private var achievements: some View {
        Explore(leaf: .init(squares: session.tiles.count))

        Divider()
        
        HStack {
            Text(.streak(value: session.chart.streak.current)
                .numeric(font: .body.monospacedDigit().weight(.regular),
                         color: .primary))
            .lineLimit(1)
            
            Spacer()
            
            Text(.walks(value: session.chart.walks)
                .numeric(font: .body.monospacedDigit().weight(.regular),
                         color: .primary))
            .lineLimit(1)
        }
        .font(.footnote.weight(.regular))
        .foregroundColor(.secondary)
    }
    
    @ViewBuilder private var time: some View {
        title(value: "Time", trend: session.chart.duration.trend)
        Item(title: "average", value: .duration(value: session.chart.duration.average))
        Item(title: "max", value: .duration(value: session.chart.duration.max))
        Item(title: "total", value: .duration(value: session.chart.duration.total))
    }
    
    @ViewBuilder private var steps: some View {
        title(value: "Steps", trend: session.chart.steps.trend)
        Item(title: "average", value: .plain(value: session.chart.steps.average))
        Item(title: "max", value: .plain(value: session.chart.steps.max))
        Item(title: "total", value: .plain(value: session.chart.steps.total))
    }
    
    @ViewBuilder private var distance: some View {
        title(value: "Distance", trend: session.chart.metres.trend)
        Item(title: "average", value: .metres(value: session.chart.metres.average, digits: 1))
        Item(title: "max", value: .metres(value: session.chart.metres.max, digits: 1))
        Item(title: "total", value: .metres(value: session.chart.metres.total, digits: 1))
    }
    
    @ViewBuilder private var calories: some View {
        title(value: "Calories", trend: session.chart.calories.trend)
        Item(title: "average", value: .plain(value: session.chart.calories.average))
        Item(title: "max", value: .plain(value: session.chart.calories.max))
        Item(title: "total", value: .plain(value: session.chart.calories.total))
    }
    
    private func title(value: String, trend: Chart.Trend) -> some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .stroke(trend.color, lineWidth: 2)
                Image(systemName: trend.symbol)
                    .foregroundColor(trend.color)
                    .font(.system(size: 12, weight: .bold))
                    .frame(width: 24, height: 24)
            }
            .fixedSize()
            
            Text(value)
                .font(.callout.weight(.medium))
                .lineLimit(1)
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, 5)
        .padding(.leading, 4)
    }
}
