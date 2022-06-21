import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                achievements
                time
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
    }
    
//    @ViewBuilder private var health: some View {
//        title(value: "Time")
//
//        Item(value: .duration(value: session.chart.duration.total),
//             trend: nil)
//
//        title(value: "Health")
//
//        Item(value: .steps(value: session.chart.steps.total),
//             trend: session.chart.steps.trend)
//
//        Item(value: .metres(value: session.chart.metres.total, digits: 0),
//             trend: session.chart.metres.trend)
//
//        Item(value: .calories(value: session.chart.calories.total, digits: 0),
//             trend: session.chart.calories.trend)
//    }
    
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
    }
}
