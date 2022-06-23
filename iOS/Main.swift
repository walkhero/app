import SwiftUI

struct Main: View {
    let session: Session
    @State private var navigation = Navigation.statistics
    
    var body: some View {
        content
            .transition(.opacity)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                VStack(spacing: 0) {
                    Divider()
                    HStack(spacing: 0) {
                        Item(navigation: $navigation, item: .settings, symbol: "gear", size: 20)
                            .padding(.leading, 8)
                        Item(navigation: $navigation, item: .calendar, symbol: "calendar", size: 21)
                        
                        Spacer()
                        
                        Button {
                            Task {
                                await cloud.start()
                            }
                        } label: {
                            Image(systemName: "figure.walk.circle.fill")
                                .font(.system(size: 40, weight: .bold))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, Color.accentColor)
                                .frame(width: 64, height: 70)
                                .contentShape(Rectangle())
                        }
                        
                        Spacer()
                        
                        Item(navigation: $navigation, item: .statistics, symbol: "chart.pie", size: 21)
                        Item(navigation: $navigation, item: .map, symbol: "globe.europe.africa", size: 23)
                            .padding(.trailing, 8)
                    }
                }
                .background(Color(.systemBackground))
            }
    }
    
    @ViewBuilder private var content: some View {
        switch navigation {
        case .map:
            Mapper(session: session)
        case .statistics:
            Stats(session: session)
        case .calendar:
            Streak(calendar: session.chart.calendar)
        case .settings:
            Settings()
        }
    }
}
