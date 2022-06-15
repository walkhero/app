import SwiftUI

extension Walking {
    struct Card: ViewModifier {
        func body(content: Content) -> some View {
            ZStack {
                Rectangle()
                    .fill(Color(.tertiarySystemBackground))
                content
                    .padding()
                    .padding(.horizontal, 2)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: .init(white: 0, opacity: 0.075), radius: 5, y: 3)
            .padding(.horizontal)
        }
    }
}
