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
        VStack {
            if !calendar.isEmpty {
                Section {
                    Week()
                } header: {
                    Navigation(index: $index, calendar: calendar)
                        .textCase(nil)
                }
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
                .listRowSeparator(.hidden)

                Section {
                    Month(days: calendar[index],
                          previous: index > 0 && calendar[index - 1].items.last!.last!.content,
                          next: index < calendar.count - 1 && calendar[index + 1].items.first!.first!.content)
                }
                .allowsHitTesting(false)
            }
            Spacer()
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Main.Title(title: "Streak")
        }
    }
}
