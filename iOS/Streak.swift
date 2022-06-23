import SwiftUI
import Dater

struct Streak: View {
    let calendar: [Days<Bool>]
    @State private var index: Int
    
    init(calendar: [Days<Bool>]) {
        self.calendar = calendar
        index = calendar.isEmpty ? 0 : calendar.count - 1
    }

    var body: some View {
        VStack(spacing: 0) {
            Navigation(index: $index, calendar: calendar)

            Divider()
            
            HStack(spacing: 0) {
                ForEach(0 ..< 7) {
                    Text(Calendar.global.date(from: .init(weekday: $0 + Calendar.global.firstWeekday % 7,
                                                          weekOfMonth: 1))!,
                         format: .dateTime.weekday(.narrow))
                        .font(.footnote.weight(.bold))
                        .frame(maxWidth: .greatestFiniteMagnitude)
                }
            }
            .foregroundColor(.accentColor)
            .padding(.vertical)
            .frame(maxWidth: 350)
            
            Divider()
            
            Month(days: calendar[index])
                .frame(maxWidth: 350)
                .animation(.spring(), value: index)
            
            Spacer()
            
            if index < calendar.count - 1 {
                Button("Today") {
                    index = calendar.count - 1
                }
                .font(.callout.weight(.medium))
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 20)
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Main.Title(title: "Streak") {
                Text(Calendar.global.date(from: .init(year: .init(calendar[index].year),
                                                      month: .init(calendar[index].month)))!,
                     format: .dateTime.year().month(.wide))
                .font(.body.weight(.semibold))
                .foregroundColor(.accentColor)
                .padding(.trailing)
            }
        }
    }
}
