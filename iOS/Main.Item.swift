import SwiftUI

extension Main {
    struct Item: View {
        @Binding var navigation: Navigation
        let item: Navigation
        let symbol: String
        let size: CGFloat
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    navigation = item
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(navigation == item ? Color.accentColor.opacity(0.6) : .clear)
                        .frame(width: 40, height: 40)
                    Image(systemName: symbol)
                        .font(.system(size: size, weight: navigation == item ? .medium : .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(navigation == item ? .white : .secondary)
                        .frame(width: 64, height: 70)
                        .contentShape(Rectangle())
                }
            }
        }
    }
}
