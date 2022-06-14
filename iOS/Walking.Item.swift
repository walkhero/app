import SwiftUI

extension Walking {
    struct Item: View {
        let value: Text
        let title: String
        
        var body: some View {
            HStack {
                value
                    .font(.title2.monospacedDigit().weight(.light))
                + Text(" " + title)
                    .font(.footnote.weight(.regular))
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.leading, 2)
            .modifier(Card())
        }
    }
}
