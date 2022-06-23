import SwiftUI

extension Stats {
    struct Item: View {
        let title: String?
        let value: AttributedString
        let content: Detail?
        @State private var detail = false
        
        var body: some View {
            if let title = title {
                Text(title)
                    .font(.callout.weight(.medium))
                    .foregroundStyle(.tertiary)
                    .padding(.leading, 20)
                    .padding(.top, 10)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            
            HStack(spacing: 0) {
                Text(value
                    .numeric(font: .title3.monospacedDigit().weight(.regular),
                             color: .primary))
                    .font(.footnote.weight(.regular))
                    .foregroundColor(.secondary)
                    .padding(.leading, 2)
                
                Spacer()
                
                Button {
                    guard content != nil else { return }
                    detail = true
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16, weight: .medium))
                        .contentShape(Rectangle())
                }
                .opacity(content == nil ? 0.3 : 1)
                .disabled(content == nil)
                .foregroundColor(.secondary)
                .buttonBorderShape(.capsule)
                .buttonStyle(.bordered)
            }
            .modifier(Card())
            .sheet(isPresented: $detail) {
                Sheet(rootView: content!)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
