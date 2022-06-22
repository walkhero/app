import SwiftUI

extension Stats {
    struct Item: View {
        let title: String
        let value: AttributedString
        
        var body: some View {
            Text(value.numeric(font: .body.monospacedDigit().weight(.medium),
                                 color: .primary)
                 + .init(" " + title))
            .font(.footnote.weight(.regular))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            .modifier(Card())
        }
    }
}
