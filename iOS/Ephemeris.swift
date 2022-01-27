import SwiftUI
import Dater
import Hero

struct Ephemeris: View, Equatable {
    @State private var calendar = [Days<Bool>]()
    @State private var index = 0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
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
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.callout.weight(.medium))
                            .padding(.leading)
                            .frame(height: 34)
                            .contentShape(Rectangle())
                            .allowsHitTesting(false)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onReceive(cloud) {
            calendar = $0.calendar
            index = calendar.count - 1
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
