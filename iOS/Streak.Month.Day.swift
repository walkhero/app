import SwiftUI

extension Streak.Month {
    struct Day: View {
        let index: UInt8
        let hit: Bool
        
        var body: some View {
            ZStack {
                if hit {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 35, height: 35)
                }
                
                Text("\(index)")
                    .font(.footnote.weight(hit ? .bold : .regular))
                    .foregroundColor(hit ? .white : .secondary)
            }
            .frame(height: 60)
            .frame(maxWidth: .greatestFiniteMagnitude)
        }
    }
}
