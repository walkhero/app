import SwiftUI

extension Walking {
    struct Streak: View {
        let streak: Int
        let walks: Int
        
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                Text(.streak(value: streak)
                    .numeric(font: .largeTitle.monospacedDigit().weight(.regular),
                             color: .primary))
                    .font(.footnote.weight(.regular))
                    .foregroundColor(.secondary)
                Spacer()
                if walks > 0 {
                    Text(.walks(value: walks))
                        .font(.footnote.monospacedDigit().weight(.light))
                        .foregroundStyle(.secondary)
                }
            }
            .modifier(Card())
        }
    }
}
