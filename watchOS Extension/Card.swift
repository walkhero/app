import SwiftUI

struct Card: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(Color.accentColor.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
