import SwiftUI
import Combine

extension Map {
    struct Content: View {
        @ObservedObject var status: Status
        weak var health: Health!
        weak var leaderboards: PassthroughSubject<Void, Never>!
        weak var animate: PassthroughSubject<UISheetPresentationController.Detent.Identifier, Never>!
        @State private var walking: Date?
        
        var body: some View {
            List {
                if let walking = walking {
                    Walking(status: status,
                            health: health,
                            animate: animate,
                            started: walking)
                }
                Geo()
                Game(status: status, leaderboards: leaderboards)
            }
            .listStyle(.insetGrouped)
            .sheet(isPresented: $status.froob, content: Froob.init)
            .safeAreaInset(edge: .top, spacing: 0) {
                Header(walking: walking != nil,
                       health: health,
                       animate: animate)
            }
            .onReceive(cloud) { model in
                let started = model.walking
                withAnimation(.easeInOut(duration: 0.5)) {
                    walking = started
                }
                
                if let date = started {
                    if !health.started {
                        health.start(date: date)
                    }
                    
                    if !location.started {
                        location.start()
                    }
                }
            }
        }
    }
}
