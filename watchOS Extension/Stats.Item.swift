import SwiftUI
import Hero

extension Stats {
    struct Item: View {
        let title: String
        let trend: Chart.Trend?
        let average: AttributedString
        let max: AttributedString
        let total: AttributedString
        let progress: Progress
        
        var body: some View {
            Divider()
                .padding(.vertical, 15)
            
            if let trend = trend {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.accentColor.opacity(0.4))
                    Image(systemName: trend.symbol)
                        .foregroundColor(.accentColor)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 32, height: 32)
                }
                .fixedSize()
                .padding(.bottom, 2)
            }
            
            Text(title)
                .font(.title3.weight(.medium))
            
            Text(total
                .numeric(font: .title3.monospacedDigit().weight(.medium),
                         color: .white))
            .font(.callout.weight(.regular))
            .foregroundStyle(.secondary)
            .padding(.bottom, 10)
            
            Text(average
                .numeric(font: .body.monospacedDigit().weight(.regular),
                         color: .white))
            .font(.footnote.weight(.regular))
            .foregroundStyle(.secondary)
            .padding(.leading)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            
            ZStack {
                Capsule()
                    .fill(.quaternary)
                progress
                    .stroke(Color.accentColor, style: .init(lineWidth: 8, lineCap: .round))
            }
            .frame(height: 8)
            .padding(.horizontal, 12)
            
            Text(max
                .numeric(font: .body.monospacedDigit().weight(.regular),
                         color: .white))
            .font(.footnote.weight(.regular))
            .foregroundStyle(.secondary)
            .padding(.trailing)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
        }
    }
}
