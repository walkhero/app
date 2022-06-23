import SwiftUI

extension Streak.Month {
    struct Day: View {
        let index: UInt8
        let hit: Bool
        let future: Bool
        
        var body: some View {
            ZStack {
                if hit {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 30, height: 30)
                }
                
                Text("\(index)")
                    .font(.footnote.weight(hit ? .medium : .light))
                    .foregroundStyle(future ? .tertiary : .primary)
                    .foregroundColor(hit ? .white : .secondary)
            }
            .frame(height: 50)
            .frame(maxWidth: .greatestFiniteMagnitude)
        }
    }
}
