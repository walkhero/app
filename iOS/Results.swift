import SwiftUI
import Hero

struct Results: View, Equatable {
    let session: Session
    let summary: Summary
    private let dates = (0 ..< 20)
        .map {
            Date(timeIntervalSinceNow: .init($0) / 10)
        }
    
    var body: some View {
        VStack(spacing: 0) {
            TimelineView(.explicit(dates)) { timeline in
                item(date: timeline.date,
                     index: 1) {
                    Text(.ordinal(value: summary.walks)
                        .numeric(font: .largeTitle.weight(.bold),
                                 color: .primary))
                        .font(.title2.weight(.regular))
                        .foregroundStyle(.secondary)
                        .padding(.top, 20)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                }
                
                item(date: timeline.date,
                     index: 2) {
                    Item(value: .duration(value: summary.duration))
                }
                
                item(date: timeline.date,
                     index: 3) {
                    Item(value: .streak(value: summary.streak))
                }
                
                item(date: timeline.date,
                     index: 4) {
                    Item(value: .squares(value: summary.squares))
                }
                
                item(date: timeline.date,
                     index: 5) {
                    Item(value: .steps(value: summary.steps))
                }
                
                item(date: timeline.date,
                     index: 6) {
                    Item(value: .metres(value: summary.metres, fraction: true))
                }
                
                item(date: timeline.date,
                     index: 7) {
                    Item(value: .calories(value: summary.calories, caption: true))
                }
                
                Spacer()
                
                item(date: timeline.date,
                     index: 9) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            session.achievement = summary.leaf
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
                    .padding(.bottom, 30)
                }
            }
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .padding(.horizontal, 30)
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
        if date > dates[index] {
            content()
                .opacity(date > dates[index + 1] ? 1 : 0.3)
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
