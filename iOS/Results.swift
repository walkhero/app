import SwiftUI
import Hero

struct Results: View {
    let session: Session
    let summary: Summary
    private let dates = (0 ..< 15)
        .map {
            Date.now.timeIntervalSince1970 + (.init($0) / 10)
        }
    @Environment(\.scenePhase) private var phase
    
    var body: some View {
        VStack(spacing: 0) {
            TimelineView(.animation(minimumInterval: 0.05, paused: phase != .active)) { timeline in
                item(date: timeline.date,
                     index: 4) {
                    Text(.ordinal(value: summary.walks)
                        .numeric(font: .title.weight(.bold),
                                 color: .primary))
                        .font(.title3.weight(.regular))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                }
                
                item(date: timeline.date,
                     index: 6) {
                    Item(value: .duration(value: summary.duration))
                }
                
                item(date: timeline.date,
                     index: 7) {
                    Item(value: .streak(value: summary.streak))
                }
                
                item(date: timeline.date,
                     index: 8) {
                    Item(value: .squares(value: summary.squares))
                }
                
                item(date: timeline.date,
                     index: 9) {
                    Item(value: .steps(value: summary.steps))
                }
                
                item(date: timeline.date,
                     index: 10) {
                    Item(value: .metres(value: summary.metres, digits: 3))
                }
                
                item(date: timeline.date,
                     index: 11) {
                    Item(value: .calories(value: summary.calories, digits: 2, caption: true))
                }
                
                Spacer()
                
                item(date: timeline.date,
                     index: 13) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            session.summary = nil
                        }
                        
                        if Defaults.rate {
                            UIApplication.shared.review()
                        }
                    } label: {
                        Text("Done")
                            .font(.callout.weight(.bold))
                            .padding(.vertical, 5)
                            .frame(minWidth: 240)
                    }
                    .tint(.white)
                    .foregroundColor(.accentColor)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .padding(30)
        .background(LinearGradient(stops: [.init(color: .init("Middle"), location: 0),
                                           .init(color: .init("Top"), location: 0.75),
                                           .init(color: .init("Bottom"), location: 1)],
                                   startPoint: .top,
                                   endPoint: .bottom))
        .foregroundColor(.white)
        .preferredColorScheme(.dark)
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
