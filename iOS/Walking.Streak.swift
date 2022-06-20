import SwiftUI

extension Walking {
    struct Streak: View {
        let streak: Int
        let walks: Int
        
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                Text(.streak(value: streak)
                    .numeric(font: .title.monospacedDigit().weight(.medium),
                             color: .primary))
                    .font(.callout.weight(.regular))
                    .foregroundColor(.secondary)
                Spacer()
                if walks > 0 {
                    Text(.walks(value: walks))
                        .font(.footnote.monospacedDigit().weight(.regular))
                        .foregroundStyle(.secondary)
                }
            }
            .modifier(Card())
        }
    }
}
