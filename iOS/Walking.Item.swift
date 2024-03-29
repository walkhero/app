import SwiftUI

extension Walking {
    struct Item: View {
        let value: AttributedString
        let limit: AttributedString?
        let progress: Progress
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(value
                        .numeric(font: .title.monospacedDigit().weight(.medium),
                                 color: .primary))
                        .font(.callout.weight(.regular))
                        .foregroundColor(.secondary)
                    Spacer()
                    if let limit = limit {
                        Text(limit)
                            .font(.footnote.monospacedDigit().weight(.regular))
                            .foregroundStyle(.secondary)
                    }
                }
                ZStack {
                    Capsule()
                        .fill(.quaternary)
                    progress
                        .stroke(Color.accentColor, style: .init(lineWidth: 3, lineCap: .round))
                }
                .frame(height: 2)
            }
            .padding(.leading, 2)
            .modifier(Card())
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
