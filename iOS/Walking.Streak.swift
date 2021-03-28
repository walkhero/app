import SwiftUI
import Hero

extension Walking {
    struct Streak: View {
        @Binding var session: Session
        let streak: Hero.Streak
        
        var body: some View {
            Text("STREAK")
                .font(.headline)
            Spacer()
            ZStack {
                Circle()
                    .fill(Challenge.streak.background)
                Text(NSNumber(value: streak.current), formatter: session.decimal)
                    .font(Font.title.bold())
                    .foregroundColor(.white)
                    .padding()
            }
            .fixedSize()
            if streak.maximum > streak.current {
                HStack {
                    Text("Max")
                    Text(NSNumber(value: streak.maximum), formatter: session.decimal)
                }
                .font(.title3)
                .foregroundColor(.secondary)
            }
            ZStack {
                Bar(percent: 1)
                    .stroke(Color(.secondarySystemBackground), style: .init(lineWidth: 8, lineCap: .round))
                Bar(percent: streak.maximum == 0 ? 0 : .init(streak.current) / .init(streak.maximum))
                    .stroke(LinearGradient(
                                gradient: .init(colors: [.pink, .init(.systemIndigo)]),
                                startPoint: .leading,
                                endPoint: .trailing), style: .init(lineWidth: 8, lineCap: .round))
            }
            .frame(width: 160, height: 10)
            Spacer()
        }
    }
}
