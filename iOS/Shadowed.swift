import SwiftUI

struct Shadowed: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .primary.opacity(0.3), radius: 4, y: 2)
    }
}
