import SwiftUI

extension Walking.Stats {
    struct Item: View {
        let text: Text
        let caption: Text?
        let title: String
        
        var body: some View {
            VStack(spacing: 0) {
                Spacer()
                text
                    .font(.title2.monospacedDigit().weight(.light))
                if let caption = caption {
                    caption
                        .foregroundColor(.init(.tertiaryLabel))
                        .font(.caption.monospacedDigit())
                        .padding(.bottom, 4)
                }
                ZStack {
                    Capsule()
                        .fill(Color.accentColor)
                    Text(title)
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                }
                .fixedSize()
            }
            .frame(width: 115, height: 80)
        }
    }
}
