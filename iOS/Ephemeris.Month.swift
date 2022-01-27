import SwiftUI
import Dater
import Hero

extension Ephemeris {
    struct Month: View {
        let days: Days<Bool>
        let previous: Bool
        let next: Bool

        var body: some View {
            ForEach(0 ..< days.items.count, id: \.self) { week in
                HStack(spacing: 0) {
                    Spacer()
                    ForEach(0 ..< days.items[week].count, id: \.self) {
                        Day(index: days.items[week][$0].value,
                            today: days.items[week][$0].today,
                            continouos: continouos(week: week, day: $0))
                            .padding(.leading, $0 == 0 ? leading(week) : 0)
                            .padding(.trailing, $0 == days.items[week].count - 1 ? trailing(week) : 0)
                    }
                    Spacer()
                }
            }
        }

        private func leading(_ week: Int) -> CGFloat {
            .init(Calendar.current
                    .leadingWeekdays(year: days.year,
                                     month: days.month,
                                     day: days.items[week].first!.value))
            * 40
        }

        private func trailing(_ week: Int) -> CGFloat {
            .init(Calendar.current
                    .trailingWeekdays(year: days.year,
                                      month: days.month,
                                      day: days.items[week].last!.value))
            * 40
        }

        private func continouos(week: Int, day: Int) -> Continuous {
            days.items[week][day].content
                ? previous(week, day)
                    ? next(week, day)
                        ? .middle
                        : .trailing
                    : next(week, day)
                        ? .leading
                        : .single
                : .none
        }

        private func previous(_ week: Int, _ day: Int) -> Bool {
            day > 0
                ? days.items[week][day - 1].content
                : week > 0
                    ? days.items[week - 1].last!.content
                    : previous
        }

        private func next(_ week: Int, _ day: Int) -> Bool {
            day < days.items[week].count - 1
                ? days.items[week][day + 1].content
                : week < days.items.count - 1
                    ? days.items[week + 1].first!.content
                    : next
        }
    }
}
