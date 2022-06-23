import SwiftUI
import Dater

extension Streak {
    struct Month: View {
        let days: Days<Bool>

        var body: some View {
            ForEach(0 ..< days.items.count, id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(0 ..< leading(week: week), id: \.self) { _ in
                        blank
                    }
                    
                    ForEach(0 ..< days.items[week].count, id: \.self) {
                        Day(index: days.items[week][$0].value,
                            hit: days.items[week][$0].content,
                            future: Calendar.global.date(
                                from: .init(
                                    year: .init(days.year),
                                    month: .init(days.month),
                                    day: .init(days.items[week][$0].value)))! > Date.now)
                    }
                    
                    ForEach(0 ..< trailing(week: week), id: \.self) { _ in
                        blank
                    }
                }
            }
        }
        
        private var blank: some View {
            Rectangle()
                .fill(Color.clear)
                .frame(height: 50)
                .frame(maxWidth: .greatestFiniteMagnitude)
        }

        private func leading(week: Int) -> Int {
            Calendar.global
                    .leadingWeekdays(year: days.year,
                                     month: days.month,
                                     day: days.items[week].first!.value)
        }

        private func trailing(week: Int) -> Int {
            Calendar.global
                    .trailingWeekdays(year: days.year,
                                      month: days.month,
                                      day: days.items[week].last!.value)
        }
    }
}
