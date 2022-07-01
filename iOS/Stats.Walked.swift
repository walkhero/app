import SwiftUI

extension Stats {
    struct Walked: View {
        let updated: DateInterval?
        
        var body: some View {
            HStack {
                if let updated = updated {
                    Text("Walked")
                        .font(.callout.weight(.medium))
                        .foregroundColor(.accentColor)
                    Text(.duration(value: .init(updated.duration)))
                        .font(.callout.weight(.medium).monospacedDigit())
                    Text(updated.end, format: .relative(presentation: .named,
                                                        unitsStyle: .abbreviated))
                    .font(.callout.weight(.medium))
                    .foregroundColor(.accentColor)
                }
            }
            .padding(.vertical)
        }
    }
}
