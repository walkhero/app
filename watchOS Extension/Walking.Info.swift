import SwiftUI
import Hero

extension Walking {
    struct Info: View {
        @ObservedObject var walker: Walker
        let session: Session
        let chart: Chart
        @State private var limit = false
        
        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    Top(chart: chart, walking: session.walking)
                        .padding(.top, 12)
                    
                    if limit {
                        Text((.streak(value: chart.streak.current)
                              + .init(", ")
                              + .walks(value: chart.walks))
                            .numeric(font: .system(size: 16, weight: .regular).monospacedDigit(),
                                     color: .secondary))
                        .font(.system(size: 14, weight: .regular))
                        .lineLimit(1)
                        .foregroundStyle(.tertiary)
                        .padding(.bottom, 15)
                    }
                    
                    Explore(walker: walker, limit: limit)
                    
                    Item(value: .steps(value: walker.steps),
                         limit: limit && chart.steps.max > 0
                         ? .steps(value: chart.steps.max)
                         : nil,
                         indicator: .init(current: walker.steps,
                                          max: chart.steps.max,
                                          height: 6))
                    
                    Item(value: .metres(value: walker.metres, fraction: true),
                         limit: limit && chart.metres.max > 0
                         ? .metres(value: chart.metres.max, fraction: false)
                         : nil,
                         indicator: .init(current: walker.metres,
                                          max: chart.metres.max,
                                          height: 6))
                    
                    Item(value: .calories(value: walker.calories, caption: true),
                         limit: limit && chart.calories.max > 0
                         ? .calories(value: chart.calories.max, caption: true)
                         : nil,
                         indicator: .init(current: walker.calories,
                                          max: chart.calories.max,
                                          height: 6))
                }
                .animation(.easeInOut(duration: 0.3), value: limit)
                .onTapGesture {
                    limit.toggle()
                }
                .padding(.bottom, 35)
            }
        }
    }
}
