import SwiftUI

extension Walking {
    struct Streak: View {
        let streak: Int
        let walks: Int
        
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                Text(.streak(value: streak)
                    .numeric(font: .title2.monospacedDigit().weight(.medium),
                             color: .primary))
                    .font(.callout.weight(.regular))
                    .foregroundStyle(.secondary)
                Spacer()
                if walks > 0 {
                    Text(.walks(value: walks)
                        .numeric(font: .title2.monospacedDigit().weight(.medium),
                                 color: .primary))
                        .font(.footnote.monospacedDigit().weight(.regular))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top)
        }
    }
}
