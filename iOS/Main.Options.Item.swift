import SwiftUI

extension Main.Options {
    struct Item: View {
        let symbol: String
        let active: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 36, height: 36)
                    Circle()
                        .stroke(Color(.tertiaryLabel), lineWidth: 1)
                        .frame(width: 36, height: 36)
                    Image(systemName: symbol)
                        .foregroundColor(active ? .primary : .init(.tertiaryLabel))
                }
                .contentShape(Rectangle())
            }
            .padding([.top, .trailing])
        }
    }
}
