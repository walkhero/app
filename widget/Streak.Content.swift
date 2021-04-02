import SwiftUI

extension Streak {
    struct Content: View {
        let entry: Entry
        
        var body: some View {
            HStack {
                VStack {
                    Image(systemName: "figure.walk")
                        .font(.largeTitle)
                    Text(NSNumber(value: entry.streak.current), formatter: NumberFormatter.decimal)
                        .font(.largeTitle)
                    Image(systemName: entry.today ? "checkmark.circle.fill" : "exclamationmark.square.fill")
                        .foregroundColor(entry.today ? .primary : .secondary)
                }
                VStack {
                    Text(verbatim: DateFormatter.monther.string(
                            from: Calendar.current.date(from: .init(month: entry.year.months[index].value))!))
                        .font(Font.callout.bold())
                    Ephemeris.Week(weeker: .weeker)
                    Ephemeris.Month(month: entry.year.months[index],
                                    previous: index > 0 && entry.year.months[index - 1].days.last!.last!.hit,
                                    next: index < entry.year.months.count - 1 && entry.year.months[index + 1].days.first!.first!.hit)
                }
                .padding()
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
