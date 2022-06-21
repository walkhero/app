import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                achievements
                time
                steps
                distance
                calories
            }
        }
    }
    
    @ViewBuilder private var achievements: some View {
        Explore(leaf: .init(squares: session.tiles.count))

        Divider()
            .padding(.vertical, 10)
        
        HStack {
            Text(.streak(value: session.chart.streak.current)
                .numeric(font: .title3.monospacedDigit().weight(.regular),
                         color: .primary))
            .lineLimit(1)
            
            Spacer()
            
            Text(.walks(value: session.chart.walks)
                .numeric(font: .title3.monospacedDigit().weight(.regular),
                         color: .primary))
            .lineLimit(1)
        }
        .font(.footnote.weight(.regular))
        .foregroundColor(.secondary)
        .padding(.horizontal)
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
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: 30, height: 30)
            }
            .fixedSize()
            
            Text(value)
                .font(.callout.weight(.semibold))
                .foregroundStyle(.secondary)
                .lineLimit(1)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 30)
        .padding(.bottom, 10)
    }
}
