import SwiftUI
import Hero

extension Stats {
    struct Item: View {
        let value: AttributedString
        let item: Chart.Item
        @State private var detail = false
        
        init(value: AttributedString, item: Chart.Item) {
            self.value = value.numeric(font: .title3.monospacedDigit().weight(.regular),
                                       color: .primary)
            self.item = item
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
                .foregroundColor(.primary)
                .buttonBorderShape(.capsule)
                .buttonStyle(.bordered)
            }
            .modifier(Card())
            .sheet(isPresented: $detail) {
                Sheet(rootView: Circle())
            }
        }
    }
}
