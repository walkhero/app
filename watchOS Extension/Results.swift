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
            VStack(spacing: 0) {
                Text(.ordinal(value: summary.walks)
                    .numeric(font: .title.weight(.bold),
                             color: .primary))
                    .font(.title.weight(.regular))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.bottom)
                
                Item(value: .duration(value: summary.duration))
                
                Item(value: .streak(value: summary.streak))
                
                Item(value: .squares(value: summary.squares))
                
                Item(value: .steps(value: summary.steps))
                
                Item(value: .metres(value: summary.metres, fraction: true))
                
                Item(value: .calories(value: summary.calories, caption: true))
                
                Spacer()
                    .frame(height: 20)
                
                Button("Done") {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        session.achievement = summary.leaf
                        session.summary = nil
                    }
                }
                .font(.callout.weight(.bold))
                .tint(.white)
                .foregroundColor(.accentColor)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .edgesIgnoringSafeArea(.all)
        .background(LinearGradient(stops: [.init(color: .init("Middle"), location: 0),
                                           .init(color: .init("Bottom"), location: 1)],
                                   startPoint: .top,
                                   endPoint: .bottom))
    }
}
