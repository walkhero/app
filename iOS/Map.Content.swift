import SwiftUI
import Combine

extension Map {
    struct Content: View {
        weak var status: Status!
        weak var leaderboards: PassthroughSubject<Void, Never>!
        weak var animate: PassthroughSubject<UISheetPresentationController.Detent.Identifier, Never>!
        @State private var walking: Date?
        
        var body: some View {
            List {
                if let walking = walking {
                    Walking(status: status,
                            animate: animate,
                            started: walking)
                }
                Geo()
                Game(status: status, leaderboards: leaderboards)
            }
            .listStyle(.insetGrouped)
            .safeAreaInset(edge: .top, spacing: 0) {
                Header(walking: walking != nil, animate: animate)
            }
            .onReceive(cloud) { model in
                withAnimation(.easeInOut(duration: 0.5)) {
                    walking = model.walking
                }
            }
        }
    }
}
