import SwiftUI
import Hero

extension Ephemeris {
    struct Month: View {
        @Binding var session: Session
        let month: Year.Month
        let previous: Bool
        let next: Bool
        
        var body: some View {
            ForEach(0 ..< month.days.count, id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(0 ..< month.days[week].count, id: \.self) {
                        Day(index: month.days[week][$0].value, continouos: continouos(week, $0))
                    }
                }
                .padding(.leading, leading(week))
                .padding(.trailing, trailing(week))
            }
        }
        
        private func leading(_ week: Int) -> CGFloat {
            .init(Calendar.current
                    .leadingWeekdays(year: 2021, month: month.value, day: month.days[week].first!.value))
                * Metrics.calendar.day.size
        }
        
        private func trailing(_ week: Int) -> CGFloat {
            .init(Calendar.current
                    .trailingWeekdays(year: 2021, month: month.value, day: month.days[week].last!.value))
                * Metrics.calendar.day.size
        }
        
        private func continouos(_ week: Int, _ day: Int) -> Continuous {
            month.days[week][day].hit
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
                ? month.days[week][day - 1].hit
                : week > 0
                    ? month.days[week - 1].last!.hit
                    : previous
        }
        
        private func next(_ week: Int, _ day: Int) -> Bool {
            day < month.days[week].count - 1
                ? month.days[week][day + 1].hit
                : week < month.days.count - 1
                    ? month.days[week + 1].first!.hit
                    : next
        }
    }
}
