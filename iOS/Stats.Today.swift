import SwiftUI

extension Stats {
    struct Today: View {
        let updated: DateInterval?
        
        var body: some View {
            Section {
                VStack(spacing: 10) {
                    if updated == nil || !Calendar.current.isDateInToday(updated!.start) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.title3)
                                .foregroundColor(.pink)
                            Text("No walk today")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        HStack {
                            Image(systemName: "figure.walk")
                                .font(.title3.weight(.light))
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                        .font(.title3)
                    }
                    
                    if let updated = updated {
                        HStack {
                            Spacer()
                            Text("Updated ")
                                .fontWeight(.light)
                            + Text(updated.end, format: .relative(presentation: .named))
                            Spacer()
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    }
                }
            }
            .allowsHitTesting(false)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
    }
}
