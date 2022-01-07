import SwiftUI

extension Ephemeris {
    struct Week: View {
        var body: some View {
            HStack(spacing: 0) {
                Spacer()
                ForEach(0 ..< 7) {
                    Text(Calendar.current.date(from: .init(weekday: $0 + Calendar.current.firstWeekday % 7,
                                                           weekOfMonth: 1))!,
                         format: .dateTime.weekday(.narrow))
                        .font(.caption.bold())
                        .frame(width: 40)
                }
                Spacer()
            }
            .font(.callout)
            .foregroundColor(.pink)
            .allowsHitTesting(false)
        }
    }
}
