import SwiftUI
import WidgetKit

extension Streak {
    struct Content: View {
        let entry: Entry
        @Environment(\.widgetFamily) private var family: WidgetFamily
        
        var body: some View {
            if family == .systemLarge {
                VStack(spacing: 0) {
                    Ephemeris.Week(weeker: .weeker)
                    Ephemeris.Month(month: entry.year.months[index],
                                    previous: index > 0 && entry.year.months[index - 1].days.last!.last!.hit,
                                    next: index < entry.year.months.count - 1 && entry.year.months[index + 1].days.first!.first!.hit)
                }
            } else {
                HStack {
                    Text(verbatim: months)
                        .font(.footnote.bold())
                    Spacer()
                    VStack {
                        Text("TODAY")
                            .font(.footnote)
                            .padding(.bottom)
                            .foregroundColor(.secondary)
                        Image(systemName: entry.today ? "checkmark.circle.fill" : "exclamationmark.square.fill")
                            .font(.title3)
                    }
                    .padding(.trailing)
                    VStack {
                        Image(systemName: "figure.walk")
                            .font(.footnote)
                            .padding(.bottom)
                            .foregroundColor(.secondary)
                        Text(NSNumber(value: entry.streak.current), formatter: NumberFormatter.decimal)
                            .font(.title3)
                    }
                }
                .padding(30)
            }
        }
        
        private var months: String {
            DateFormatter.monther.string(
                from: Calendar.current.date(from: .init(month: entry.year.months[0].value))!)
                + (entry.year.months.count > 1 ? "-" + DateFormatter.monther.string(
                    from: Calendar.current.date(from: .init(month: entry.year.months[index].value))!) : "")
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
