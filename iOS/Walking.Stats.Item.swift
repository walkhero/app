import SwiftUI

extension Walking.Stats {
    struct Item: View {
        let text: Text
        let caption: Text?
        let title: String
        
        var body: some View {
            VStack {
                Spacer()
                text
                    .font(.title2.monospacedDigit().weight(.light))
                if let caption = caption {
                    caption
                        .foregroundColor(.init(.tertiaryLabel))
                        .font(.caption.monospacedDigit())
                }
                Text(title)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .frame(width: 115, height: 70)
        }
    }
}
