import SwiftUI

extension Walking {
    struct Info: View {
        @ObservedObject var session: Session
        @ObservedObject var walker: Walker
        @State private var limit = false
        
        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    Top(session: session)
                        .padding(.top, 12)
                    
                    if limit {
                        Text((.streak(value: session.chart.streak.current)
                              + .init(", ")
                              + .walks(value: session.chart.walks))
                            .numeric(font: .system(size: 16, weight: .regular).monospacedDigit(),
                                     color: .secondary))
                        .font(.system(size: 14, weight: .regular))
                        .lineLimit(1)
                        .foregroundStyle(.tertiary)
                        .padding(.bottom, 15)
                    }
                    
                    Explore(walker: walker, limit: limit)
                    
                    Item(value: .steps(value: walker.steps),
                         limit: limit && session.chart.steps.max > 0
                         ? .steps(value: session.chart.steps.max)
                         : nil,
                         indicator: .init(current: walker.steps,
                                          max: session.chart.steps.max,
                                          height: 6))
                    
                    Item(value: .metres(value: walker.metres, fraction: true),
                         limit: limit && session.chart.metres.max > 0
                         ? .metres(value: session.chart.metres.max, fraction: false)
                         : nil,
                         indicator: .init(current: walker.metres,
                                          max: session.chart.metres.max,
                                          height: 6))
                    
                    Item(value: .calories(value: walker.calories, caption: true),
                         limit: limit && session.chart.calories.max > 0
                         ? .calories(value: session.chart.calories.max, caption: true)
                         : nil,
                         indicator: .init(current: walker.calories,
                                          max: session.chart.calories.max,
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
