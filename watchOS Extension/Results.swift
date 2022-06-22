import SwiftUI
import Hero

struct Results: View {
    let session: Session
    let summary: Summary
    private let dates = (0 ..< 20)
        .map {
            Date.now.timeIntervalSince1970 + (.init($0) / 10)
        }
    @Environment(\.scenePhase) private var phase
    
    var body: some View {
        ScrollView {
            VStack {
                TimelineView(.animation(minimumInterval: 0.05, paused: phase != .active)) { timeline in
                    item(date: timeline.date,
                         index: 4) {
                        Text("Finished")
                            .font(.title2.weight(.bold))
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    }
                    
                    item(date: timeline.date,
                         index: 6) {
                        Item(value: .duration(value: summary.duration))
                    }
                    
                    item(date: timeline.date,
                         index: 7) {
                        Item(value: .ordinal(value: summary.walks))
                    }
                    
                    item(date: timeline.date,
                         index: 8) {
                        Item(value: .streak(value: summary.streak))
                    }
                    
                    item(date: timeline.date,
                         index: 9) {
                        Item(value: .squares(value: summary.squares))
                    }
                    
                    item(date: timeline.date,
                         index: 10) {
                        Item(value: .steps(value: summary.steps))
                    }
                    
                    item(date: timeline.date,
                         index: 11) {
                        Item(value: .metres(value: summary.metres, digits: 3))
                    }
                    
                    item(date: timeline.date,
                         index: 12) {
                        Item(value: .calories(value: summary.calories))
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    item(date: timeline.date,
                         index: 18) {
                        Button("Done") {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                session.summary = nil
                            }
                        }
                        .font(.callout.weight(.bold))
                        .tint(.white)
                        .foregroundColor(.accentColor)
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
                    }
                }
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical, 35)
        }
        .edgesIgnoringSafeArea(.all)
        .background(LinearGradient(stops: [.init(color: .init("Middle"), location: 0),
                                           .init(color: .init("Bottom"), location: 1)],
                                   startPoint: .top,
                                   endPoint: .bottom))
    }
    
    @inlinable @ViewBuilder func item<C>(date: Date,
                                      index: Int,
                                      content: () -> C) -> some View where C : View {
        if date.timeIntervalSince1970 > dates[index] {
            content()
                .opacity(date.timeIntervalSince1970 > dates[index + 1] ? 1 : 0.3)
        }
    }
}
