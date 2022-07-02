import SwiftUI

extension Stats {
    struct Walked: View {
        let updated: DateInterval?
        
        var body: some View {
            HStack(spacing: 0) {
                if let updated = updated {
                    Text("Walked")
                        .font(.callout.weight(.medium))
                        .foregroundColor(.accentColor)
                    + Text(" ") +
                    Text(.duration(value: .init(updated.duration)))
                        .font(.callout.weight(.regular).monospacedDigit())
                    + Text(" ") +
                    Text(updated.end, format: .relative(presentation: .named,
                                                        unitsStyle: .abbreviated))
                    .font(.callout.weight(.regular))
                    .foregroundColor(.secondary)
                }
            }
            .padding(.vertical)
        }
    }
}
