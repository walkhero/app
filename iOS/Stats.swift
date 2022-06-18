import SwiftUI
import Hero

struct Stats: View {
    @ObservedObject var session: Session
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Explore(leaf: .init(squares: session.tiles.count))
                
                Streak(streak: session.chart.streak.current, walks: session.chart.walks)
                
                
            }
            .padding(.vertical, 20)
        }
    }
}
