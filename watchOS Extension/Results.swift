import SwiftUI
import Hero

struct Results: View, Equatable {
    @ObservedObject var session: Session
    let summary: Summary
    private let id = UUID()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text(.ordinal(value: summary.walks)
                    .numeric(font: .largeTitle.weight(.bold),
                             color: .primary))
                    .font(.title.weight(.regular))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.top, 25)
                
                Item(value: .duration(value: summary.duration))
                
                Item(value: .streak(value: summary.streak))
                
                Item(value: .squares(value: summary.squares))
                
                Item(value: .steps(value: summary.steps))
                
                Item(value: .metres(value: summary.metres, fraction: true))
                
                Item(value: .calories(value: summary.calories, caption: true))
                
                Button("Done") {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        session.achievement = summary.leaf
                        session.summary = nil
                    }
                }
                .font(.body.weight(.bold))
                .tint(.white)
                .foregroundColor(.accentColor)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .padding(.bottom, 50)
                .padding(.top, 35)
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.all)
        .background(LinearGradient(stops: [.init(color: .init("Middle"), location: 0),
                                           .init(color: .init("Bottom"), location: 1)],
                                   startPoint: .top,
                                   endPoint: .bottom))
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
