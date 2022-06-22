import SwiftUI

extension Walking {
    struct Streak: View {
        let streak: Int
        let walks: Int
        
        var body: some View {
            Text(.streak(value: streak)
                 + .init(", ")
                 + .walks(value: walks))
            .font(.footnote.monospacedDigit().weight(.regular))
            .lineLimit(1)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
        }
    }
}
