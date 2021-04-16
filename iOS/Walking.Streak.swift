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
                    .stroke(Color.primary.opacity(0.1), lineWidth: 16)
                Ring(percent: streak == .zero ? 0 : .init(streak.current) / .init(streak.maximum))
                    .stroke(LinearGradient(
                                gradient: .init(colors: [.pink, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing), lineWidth: 16)
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.secondary)
                    .frame(height: 50)
                Text(NSNumber(value: streak.current), formatter: session.decimal)
                    .font(Font.title.bold())
                    .frame(maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                    .padding(.bottom, 50)
            }
            .frame(width: 250, height: 250)
            Spacer()
        }
    }
}
