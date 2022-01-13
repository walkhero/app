import SwiftUI

extension Stats {
    struct Today: View {
        let updated: DateInterval?
        
        var body: some View {
            Section {
                if updated == nil || !Calendar.current.isDateInToday(updated!.start) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.title3)
                            .foregroundColor(.pink)
                        Text("No walk today")
                            .font(.body)
                    }
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                } else {
                    HStack {
                        Image(systemName: "figure.walk")
                            .font(.title3.weight(.light))
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.accentColor)
                    }
                    .font(.title3)
                    .padding(.horizontal)
                }
                
                if let updated = updated {
                    Item(text: .init(updated.end,
                                     format: .relative(presentation: .named)),
                         title: "Updated")
                }
            }
            .allowsHitTesting(false)
            .listRowBackground(Color.clear)
        }
    }
}
