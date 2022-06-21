import SwiftUI

extension Stats {
    struct Today: View {
        let updated: Date?
        
        var body: some View {
            if let updated = updated, Calendar.global.isDateInToday(updated) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.accentColor)
                    Text("Walk today")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.accentColor)
                    Spacer()
                }
            } else {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 22, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.pink)
                    Text("No walk today")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.accentColor)
                    Spacer()
                }
            }
        }
    }
}
