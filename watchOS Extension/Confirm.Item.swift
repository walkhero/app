import SwiftUI

extension Confirm {
    struct Item: View {
        let text: Text
        let title: String
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.accentColor.opacity(0.2))
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
        }
    }
}
