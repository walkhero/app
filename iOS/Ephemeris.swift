import SwiftUI
import Hero

struct Ephemeris: View {
    @State var index: Int
    let monther: DateFormatter
    let weeker: DateFormatter
    let year: Year
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
            VStack(spacing: 0) {
                Navigation(index: $index, monther: monther, months: year.months.count, month: year.months[index].value)
                Week(weeker: weeker)
                Month(month: year.months[index],
                      previous: index > 0 && year.months[index - 1].days.last!.last!.hit,
                      next: index < year.months.count - 1 && year.months[index + 1].days.first!.first!.hit)
            }
            .padding(10)
        }
        .fixedSize()
    }
}
