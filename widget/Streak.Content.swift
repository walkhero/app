import SwiftUI

extension Streak {
    struct Content: View {
        let entry: Entry
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "figure.walk")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Text(NSNumber(value: entry.streak.current), formatter: NumberFormatter.decimal)
                        .font(Font.footnote.bold())
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("TODAY")
                        .foregroundColor(.accentColor)
                        .font(.caption2)
                    Image(systemName: entry.today ? "checkmark.circle.fill" : "exclamationmark.square.fill")
                        .font(.footnote)
                }
                .padding(.horizontal, 70)
                .offset(y: 30)
                VStack {
                    Text(verbatim: DateFormatter.monther.string(
                            from: Calendar.current.date(from: .init(month: entry.year.months[index].value))!))
                        .font(Font.callout.bold())
                        .foregroundColor(.secondary)
                    Ephemeris.Week(weeker: .weeker)
                    Ephemeris.Month(month: entry.year.months[index],
                                    previous: index > 0 && entry.year.months[index - 1].days.last!.last!.hit,
                                    next: index < entry.year.months.count - 1 && entry.year.months[index + 1].days.first!.first!.hit)
                }
                .scaleEffect(0.75)
                .offset(y: 10)
            }
        }
        
        private var index: Int {
            entry.year.months.count - 1
        }
    }
}

private extension DateFormatter {
    static var weeker: Self {
        let formatter = Self()
        formatter.dateFormat = "EEEEE"
        return formatter
    }
    
    static var monther: Self {
        let formatter = Self()
        formatter.dateFormat = "MMMM"
        return formatter
    }
}

private extension NumberFormatter {
    static var decimal: Self {
        let formatter = Self()
        formatter.numberStyle = .decimal
        return formatter
    }
}
