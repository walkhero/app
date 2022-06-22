import SwiftUI

struct Indicator: ViewModifier {
    let current: Int
    let max: Int
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 2)
            .padding(.leading, 16)
            .background(background)
            .clipShape(Capsule())
    }
    
    private var background: some View {
        ZStack {
            Progress(current: 1, max: 1)
                .fill(.quaternary)
            Progress(current: current, max: max)
                .fill(Color.accentColor.opacity(1))
        }
    }
}
