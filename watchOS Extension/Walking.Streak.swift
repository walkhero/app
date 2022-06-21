import SwiftUI

extension Walking {
    struct Streak: View {
        let streak: Int
        let walks: Int
        
        var body: some View {
            Text(.streak(value: streak)
                .numeric(font: .title3.monospacedDigit().weight(.medium),
                         color: .primary)
                 + .init(", ")
                 + .walks(value: walks))
            .font(.footnote.weight(.regular))
            .lineLimit(1)
            .foregroundColor(.secondary)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            .modifier(Card())
        }
    }
}
