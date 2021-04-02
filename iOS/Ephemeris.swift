import SwiftUI
import Hero

struct Ephemeris: View {
    @Binding var session: Session
    @State var index: Int
    let year: Year
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
            VStack(spacing: 0) {
                Navigation(session: $session, index: $index, months: year.months.count, month: year.months[index].value)
                Month(session: $session, month: year.months[index],
                      previous: index > 0 && year.months[index - 1].days.last!.last!.hit,
                      next: index < year.months.count - 1 && year.months[index + 1].days.first!.first!.hit)
                    .font(.footnote)
            }
            .padding(10)
        }
        .fixedSize()
    }
}
