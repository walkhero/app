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
            
            ZStack {
                Capsule()
                    .fill(.quaternary)
                Progress(current: index, max: calendar.count - 1)
                    .stroke(Color.accentColor, style: .init(lineWidth: 5, lineCap: .round))
            }
            .frame(width: 100, height: 4)
            .padding(.bottom, 30)

            Week()
                .padding(.vertical)
            
            Month(days: calendar[index])
            
            Spacer()
        }
        .frame(maxWidth: 380)
        .padding(.top)
        .safeAreaInset(edge: .top, spacing: 0) {
            Main.Title(title: "Streak") {
                EmptyView()
            }
        }
    }
}
