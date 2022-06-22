import SwiftUI

extension Stats {
    struct Today: View {
        let updated: Date?
        
        var body: some View {
            HStack {
                Spacer()
                if let updated = updated, Calendar.global.isDateInToday(updated) {
                    Text("Walk today")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.accentColor)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.accentColor)
                } else {
                    Text("No walk today")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.accentColor)
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 20, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.pink)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }
}
