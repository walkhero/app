import SwiftUI
import Hero

struct Walking: View {
    @ObservedObject var session: Session
    let chart: Chart
    @StateObject private var walker = Walker()
    
    var body: some View {
        VStack(spacing: 5) {
            Explore(walker: walker)
                .padding(.top, 20)
            
            Item(value: .steps(value: walker.steps),
                 limit: chart.steps.max > 0 ? .steps(value: chart.steps.max) : nil,
                 progress: .init(current: walker.steps, max: chart.steps.max))
            
            Item(value: .metres(value: walker.metres, fraction: true),
                 limit: chart.metres.max > 0 ? .metres(value: chart.metres.max, fraction: true) : nil,
                 progress: .init(current: walker.metres, max: chart.metres.max))
            
            Item(value: .calories(value: walker.calories, caption: true),
                 limit: chart.calories.max > 0 ? .calories(value: chart.calories.max, caption: true) : nil,
                 progress: .init(current: walker.calories, max: chart.calories.max))
            
            Spacer()
        }
        .onChange(of: session.tiles) {
            walker.tiles = $0
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Top(session: session, walker: walker, chart: chart)
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
