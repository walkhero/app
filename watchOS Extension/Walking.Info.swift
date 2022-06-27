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
                    
                    if limit {
                        Text((.streak(value: session.chart.streak.current)
                              + .init(", ")
                              + .walks(value: session.chart.walks))
                            .numeric(font: .body.monospacedDigit().weight(.regular),
                                     color: .secondary))
                        .font(.callout.weight(.regular))
                        .lineLimit(1)
                        .foregroundStyle(.tertiary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom, 10)
                    }
                    
                    Explore(walker: walker, limit: limit)
                    
                    Item(value: .steps(value: walker.steps),
                         limit: limit && session.chart.steps.max > 0
                         ? .steps(value: session.chart.steps.max)
                         : nil,
                         indicator: .init(current: walker.steps, max: session.chart.steps.max))
                    
                    Item(value: .metres(value: walker.metres, digits: 3),
                         limit: limit && session.chart.metres.max > 0
                         ? .metres(value: session.chart.metres.max, digits: 1)
                         : nil,
                         indicator: .init(current: walker.metres, max: session.chart.metres.max))
                    
                    Item(value: .calories(value: walker.calories, digits: 2, caption: true),
                         limit: limit && session.chart.calories.max > 0
                         ? .calories(value: session.chart.calories.max, digits: 2, caption: true)
                         : nil,
                         indicator: .init(current: walker.calories, max: session.chart.calories.max))
                }
                .animation(.easeInOut(duration: 0.4), value: limit)
                .onTapGesture {
                    limit.toggle()
                }
                .padding(.horizontal)
            }
        }
    }
}
