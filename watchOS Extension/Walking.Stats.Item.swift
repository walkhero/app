import SwiftUI

extension Walking.Stats {
    struct Item: View {
        let text: Text
        let caption: Text
        let title: String
        let subtitle: String
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.accentColor.opacity(0.5))
                HStack {
                    Text(title)
                        .foregroundColor(.primary.opacity(0.4))
                        .font(.caption.weight(.light))
                    Spacer()
                    text
                        .font(.body.monospacedDigit())
                }
                .padding(.horizontal)
                .padding(.vertical, 3)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
        
            caption
                .foregroundColor(.primary.opacity(0.4))
                .font(.caption2.monospacedDigit())
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                .padding(.trailing)
        }
    }
}
