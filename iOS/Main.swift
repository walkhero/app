import SwiftUI

struct Main: View {
    let session: Session
    @State private var navigation = Navigation.statistics
    
    var body: some View {
        content
            .safeAreaInset(edge: .bottom, spacing: 0) {
                VStack(spacing: 0) {
                    Divider()
                    HStack(spacing: 0) {
                        Item(navigation: $navigation, item: .settings, symbol: "gear", size: 20)
                        Item(navigation: $navigation, item: .calendar, symbol: "calendar", size: 21)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "figure.walk.circle.fill")
                                .font(.system(size: 40, weight: .bold))
                                .symbolRenderingMode(.hierarchical)
                                .frame(width: 64, height: 70)
                                .contentShape(Rectangle())
                        }
                        
                        Spacer()
                        
                        Item(navigation: $navigation, item: .statistics, symbol: "chart.pie", size: 21)
                        Item(navigation: $navigation, item: .map, symbol: "globe.europe.africa", size: 23)
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
            Circle()
        case .settings:
            Settings()
        }
    }
}
