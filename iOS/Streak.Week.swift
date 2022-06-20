import SwiftUI

extension Streak {
    struct Week: View {
        var body: some View {
            HStack(spacing: 0) {
                ForEach(0 ..< 7) {
                    Text(Calendar.global.date(from: .init(weekday: $0 + Calendar.global.firstWeekday % 7,
                                                          weekOfMonth: 1))!,
                         format: .dateTime.weekday(.narrow))
                        .font(.footnote.weight(.bold))
                        .frame(maxWidth: .greatestFiniteMagnitude)
                }
            }
            .foregroundColor(.accentColor)
        }
    }
}
