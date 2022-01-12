import SwiftUI

extension Walking.Stats {
    struct Item: View {
        let text: Text
        let caption: Text
        let title: String
        let subtitle: String
        
        var body: some View {
            VStack {
                text
                    .font(.title2.monospacedDigit().weight(.light))
                Text(subtitle)
                    .foregroundColor(.init(.tertiaryLabel))
                    .font(.caption)
                + caption
                    .foregroundColor(.init(.tertiaryLabel))
                    .font(.caption.monospacedDigit())
                Text(title)
                    .foregroundColor(.secondary)
                    .font(.footnote.weight(.light))
            }
            .frame(width: 120)
        }
    }
}
