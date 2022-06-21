import SwiftUI

struct Walking: View {
    @ObservedObject var session: Session
    @StateObject private var walker = Walker()
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Actions(walker: walker)
            ScrollView {
                VStack {
                    Top(session: session)
                    
                    Explore(walker: walker)
                    
                    Item(value: .steps(value: walker.steps),
                         limit: session.chart.steps.max > 0 ? .steps(value: session.chart.steps.max) : nil,
                         indicator: .init(current: walker.steps, max: session.chart.steps.max))
                    
                    Item(value: .metres(value: walker.metres, digits: 3),
                         limit: session.chart.metres.max > 0 ? .metres(value: session.chart.metres.max, digits: 1) : nil,
                         indicator: .init(current: walker.metres, max: session.chart.metres.max))
                    
                    Item(value: .calories(value: walker.calories),
                         limit: session.chart.calories.max > 0 ? .calories(value: session.chart.calories.max) : nil,
                         indicator: .init(current: walker.calories, max: session.chart.calories.max))
                    
                    Streak(streak: session.chart.streak.current, walks: session.chart.walks)
                }
                .padding(.horizontal)
            }
        }
        .onChange(of: session.tiles) {
            walker.tiles = $0
        }
        .onDisappear {
            Task {
                await walker.clear()
            }
        }
        .task {
            walker.tiles = session.tiles
            await walker.start(date: .init(timestamp: session.walking))
        }
    }
}
