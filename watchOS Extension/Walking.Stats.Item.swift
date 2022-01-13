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
                    .foregroundColor(.accentColor.opacity(0.4))
                HStack {
                    Text(title)
                        .foregroundColor(.secondary)
                        .font(.footnote.weight(.light))
                    Spacer()
                    text
                        .font(.body.monospacedDigit())
                }
                .padding()
            }
            .padding(.horizontal)
        
            caption
                .foregroundColor(.primary.opacity(0.4))
                .font(.footnote.monospacedDigit())
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                .padding(.trailing)
        }
    }
}
