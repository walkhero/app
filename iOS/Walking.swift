import SwiftUI

struct Walking: View {
    @ObservedObject var session: Session
    @StateObject private var walker = Walker()
    
    var body: some View {
        VStack(spacing: 5) {
            Explore(walker: walker)
                .padding(.top, 20)
            
            Item(value: .steps(value: walker.steps),
                 limit: session.chart.steps.max > 0 ? .steps(value: session.chart.steps.max) : nil,
                 progress: .init(current: walker.steps, max: session.chart.steps.max))
            
            Item(value: .metres(value: walker.metres, fraction: true),
                 limit: session.chart.metres.max > 0 ? .metres(value: session.chart.metres.max, fraction: true) : nil,
                 progress: .init(current: walker.metres, max: session.chart.metres.max))
            
            Item(value: .calories(value: walker.calories, caption: true),
                 limit: session.chart.calories.max > 0 ? .calories(value: session.chart.calories.max, caption: true) : nil,
                 progress: .init(current: walker.calories, max: session.chart.calories.max))
            
            Spacer()
        }
        .onChange(of: session.tiles) {
            walker.tiles = $0
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Top(session: session, walker: walker)
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
