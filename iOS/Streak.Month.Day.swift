import SwiftUI

extension Streak.Month {
    struct Day: View {
        let index: Int
        let today: Bool
        
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color.accentColor)
                    .padding(.vertical, 5)
                
                if today {
                    Circle()
                        .fill(Color.accentColor.opacity(0.25))
                        .frame(width: 30, height: 30)
                }
                
                Text("\(index)")
                    .font(.caption2)
                    .fontWeight(today
                                ? .bold
                                : .regular)
                    .foregroundColor(today
                                        ? .white
                                        : .white)
            }
            .frame(height: 60)
            .frame(maxWidth: .greatestFiniteMagnitude)
        }
    }
}
