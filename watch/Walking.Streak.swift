import SwiftUI
import Hero

extension Walking {
    struct Streak: View {
        @Binding var session: Session
        let streak: Hero.Streak
        
        var body: some View {
            VStack {
                Text("STREAK")
                    .font(.footnote)
                    .padding(.leading)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                Spacer()
                Text(NSNumber(value: streak.current), formatter: session.decimal)
                    .font(Font.title2.bold())
                if streak.maximum > streak.current {
                    HStack {
                        Text("Max")
                        Text(NSNumber(value: streak.maximum), formatter: session.decimal)
                    }
                    .font(.callout)
                    .foregroundColor(.secondary)
                }
                ZStack {
                    Bar(percent: 1)
                        .stroke(Color.gray, style: .init(lineWidth: 8, lineCap: .round))
                    Bar(percent: streak.maximum == 0 ? 0 : .init(streak.current) / .init(streak.maximum))
                        .stroke(LinearGradient(
                                    gradient: .init(colors: [.pink, .purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing), style: .init(lineWidth: 8, lineCap: .round))
                }
                .frame(width: 100, height: 8)
                Spacer()
            }
        }
    }
}
