import SwiftUI
import Hero

extension Walking {
    struct Streak: View {
        @Binding var session: Session
        let streak: Hero.Streak
        
        var body: some View {
            Text("STREAK")
                .font(.headline)
                .padding(.top)
            Spacer()
            ZStack {
                Circle()
                    .stroke(Color.primary.opacity(UIApplication.dark ? 0.1 : 0.03), lineWidth: 16)
                Ring(percent: streak == .zero ? 0 : .init(streak.current) / .init(streak.maximum))
                    .stroke(LinearGradient(
                                gradient: .init(colors: [.pink, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing), lineWidth: 16)
                Image(systemName: "figure.walk")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .frame(maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                    .padding(.bottom, 60)
                Text(NSNumber(value: streak.current), formatter: session.decimal)
                    .font(Font.largeTitle.bold())
            }
            .frame(width: 250, height: 250)
            Spacer()
        }
    }
}
