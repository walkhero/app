import SwiftUI

extension Walking {
    struct Card: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.accentColor.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
    }
}
