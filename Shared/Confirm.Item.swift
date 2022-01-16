import SwiftUI

extension Confirm {
    struct Item: View {
        let text: Text
        let title: String
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.orange.opacity(0.7))
                HStack {
                    Text(title)
                        .foregroundColor(.primary.opacity(0.7))
                        .font(.caption.weight(.light))
                    Spacer()
                    text
                        .font(.body.monospacedDigit())
                }
                .padding(10)
            }
            .padding(.horizontal)
        }
    }
}
