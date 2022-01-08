import SwiftUI
import Combine

extension Map {
    struct Content: View {
        weak var status: Status!
        weak var leaderboards: PassthroughSubject<Void, Never>!
        @State private var walking: Date?
        
        var body: some View {
            List {
                if let walking = walking {
                    Walking(status: status, started: walking)
                }
                Geo()
                Game(status: status, leaderboards: leaderboards)
            }
            .listStyle(.insetGrouped)
            .safeAreaInset(edge: .top, spacing: 0) {
                Header(walking: walking != nil)
            }
            .onReceive(cloud) {
                walking = $0.walking
            }
        }
    }
}
