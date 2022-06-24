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
                Text("Finished")
                    .font(.title2.weight(.medium))
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.bottom)
                
                Item(value: .duration(value: summary.duration))
                
                Item(value: .ordinal(value: summary.walks))
                
                Item(value: .streak(value: summary.streak))
                
                Item(value: .squares(value: summary.squares))
                
                Item(value: .steps(value: summary.steps))
                
                Item(value: .metres(value: summary.metres, digits: 3))
                
                Item(value: .calories(value: summary.calories, digits: 2, caption: true))
                
                Spacer()
                    .frame(height: 20)
                
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
}
