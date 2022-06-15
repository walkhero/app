import SwiftUI

extension Walking {
    struct Item: View {
        let value: Text
        let limit: Text
        let title: String
        let percent: Double
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    value
                        .font(.title2.monospacedDigit().weight(.light))
                    Text(title)
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                    Spacer()
                    limit
                        .font(.footnote.monospacedDigit().weight(.light))
                        .foregroundStyle(.secondary)
                }
                ZStack {
                    Capsule()
                        .fill(.quaternary)
                    if percent > 0 {
                        Progress(value: min(percent, 1))
                            .stroke(Color.accentColor, style: .init(lineWidth: 3, lineCap: .round))
                    }
                }
                .frame(height: 2)
                .padding(.horizontal, 2)
            }
            .padding(.leading, 2)
            .modifier(Card())
        }
    }
}
