import SwiftUI

extension Ephemeris {
    struct Week: View {
        let weeker: DateFormatter
        
        var body: some View {
            HStack(spacing: 0) {
                ForEach(0 ..< 7) {
                    Text(verbatim: weeker.string(
                            from: Calendar.current.date(
                                from: .init(
                                    weekday: $0 + Calendar.current.firstWeekday % 7,
                                    weekOfMonth: 1))!))
                        .frame(width: Metrics.calendar.day.size)
                }
            }
            .font(.callout)
            .foregroundColor(.pink)
            .padding(.vertical, 10)
        }
    }
}
