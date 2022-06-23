import SwiftUI
import Hero

extension Stats {
    struct Detail: View {
        let title: String
        let trend: Chart.Trend?
        let average: AttributedString
        let max: AttributedString
        let total: AttributedString
        let progress: Progress
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.secondary)
                            .frame(width: 55, height: 55)
                            .contentShape(Rectangle())
                    }
                }
                .padding(.bottom, 10)
                
                if let trend = trend {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(white: 1, opacity: 0.35))
                        Image(systemName: trend.symbol)
                            .foregroundColor(.accentColor)
                            .font(.system(size: 20, weight: .medium))
                            .frame(width: 40, height: 40)
                    }
                    .fixedSize()
                }
                
                Text(title)
                    .font(.title2.weight(.medium))
                
                Text(total
                    .numeric(font: .title2.monospacedDigit().weight(.medium),
                             color: .white))
                .font(.callout.weight(.regular))
                .foregroundStyle(.secondary)
                .padding(.bottom, 30)
                
                Text(average
                    .numeric(font: .title3.monospacedDigit().weight(.regular),
                             color: .white))
                .font(.callout.weight(.regular))
                .foregroundStyle(.secondary)
                .padding(.leading, 20)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                
                ZStack {
                    Capsule()
                        .fill(.quaternary)
                    progress
                        .stroke(.white, style: .init(lineWidth: 5, lineCap: .round))
                }
                .frame(height: 5)
                .padding(.horizontal, 20)
                
                Text(max
                    .numeric(font: .title3.monospacedDigit().weight(.regular),
                             color: .white))
                .font(.callout.weight(.regular))
                .foregroundStyle(.secondary)
                .padding(.trailing, 20)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                
                Spacer()
            }
            .foregroundColor(.white)
            .background(Color.accentColor)
        }
    }
}
