import SwiftUI
import Hero

extension Stats {
    struct Item<C>: View where C : View {
        let value: AttributedString
        let content: C
        @State private var detail = false
        
        init(value: AttributedString, content: C) {
            self.value = value.numeric(font: .title3.monospacedDigit().weight(.regular),
                                       color: .primary)
            self.content = content
        }
        
        var body: some View {
            HStack(spacing: 0) {
                Text(value)
                    .font(.footnote.weight(.regular))
                    .foregroundColor(.secondary)
                    .padding(.leading, 2)
                
                Spacer()
                
                Button {
                    detail = true
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16, weight: .medium))
                        .contentShape(Rectangle())
                }
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
