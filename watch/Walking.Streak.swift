import SwiftUI
import Hero

extension Walking {
    struct Streak: View {
        @Binding var session: Session
        let streak: Hero.Streak
        
        var body: some View {
            ZStack {
                Text("STREAK")
                    .font(.footnote)
                    .padding([.leading, .top])
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                ZStack {
                    Circle()
                        .stroke(Color.primary.opacity(0.1), lineWidth: 7)
                    Ring(percent: streak == .zero ? 0 : .init(streak.current) / .init(streak.maximum))
                        .stroke(LinearGradient(
                                    gradient: .init(colors: [.pink, .purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing), lineWidth: 7)
                    Image(systemName: "figure.walk")
                        .foregroundColor(.secondary)
                        .font(.title2)
                    Text(NSNumber(value: streak.current), formatter: session.decimal)
                        .font(Font.title3.bold())
                        .frame(maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                        .padding(.bottom, Metrics.streak.padding * 2)
                }
                .padding(Metrics.streak.padding)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
