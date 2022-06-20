import SwiftUI
import Hero

extension Stats {
    struct Item<C>: View where C : View {
        let value: AttributedString
        let active: Bool
        let content: C
        @State private var detail = false
        
        var body: some View {
            HStack(spacing: 0) {
                Text(value
                    .numeric(font: .title3.monospacedDigit().weight(.regular),
                             color: .primary))
                    .font(.footnote.weight(.regular))
                    .foregroundColor(.secondary)
                    .padding(.leading, 2)
                
                Spacer()
                
                Button {
                    guard active else { return }
                    detail = true
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16, weight: .medium))
                        .contentShape(Rectangle())
                }
                .opacity(active ? 1 : 0.3)
                .disabled(!active)
                .foregroundColor(.secondary)
                .buttonBorderShape(.capsule)
                .buttonStyle(.bordered)
            }
            .modifier(Card())
            .sheet(isPresented: $detail) {
                Sheet(rootView: content)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
