import SwiftUI

struct Card: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(.tertiarySystemBackground))
            content
                .padding(18)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .init(white: 0, opacity: 0.05), radius: 5, y: 3)
        .padding(.horizontal)
    }
}
