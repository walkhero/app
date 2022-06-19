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
            if !calendar.isEmpty {
                Navigation(index: $index, calendar: calendar)
                
                ZStack {
                    Capsule()
                        .fill(.quaternary)
                    Progress(current: index, max: calendar.count - 1)
                        .stroke(Color.accentColor, style: .init(lineWidth: 5, lineCap: .round))
                }
                .frame(width: 180, height: 4)
                .padding(.bottom, 30)

                Week()
                    .padding(.vertical)
                
                Month(days: calendar[index],
                      previous: index > 0 && calendar[index - 1].items.last!.last!.content,
                      next: index < calendar.count - 1 && calendar[index + 1].items.first!.first!.content)
            }
            Spacer()
        }
        .frame(maxWidth: 380)
        .padding(.top)
        .safeAreaInset(edge: .top, spacing: 0) {
            Main.Title(title: "Streak")
        }
    }
}
