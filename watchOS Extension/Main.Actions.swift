import SwiftUI
import Hero

extension Main {
    struct Actions: View {
        let chart: Chart
        
        var body: some View {
            VStack {
                if let updated = chart.updated {
                    Text("Walked")
                        .font(.footnote.weight(.regular))
                    Text(.duration(value: .init(updated.duration)))
                        .font(.footnote.weight(.regular).monospacedDigit())
                        .foregroundStyle(.secondary)
                    Text(updated.end, format: .relative(presentation: .named,
                                                        unitsStyle: .abbreviated))
                    .font(.footnote.weight(.regular))
                    .foregroundStyle(.secondary)
                }
                
                Button {
                    Task {
                        await cloud.start()
                    }
                } label: {
                    Image(systemName: "figure.walk")
                        .font(.system(size: 24, weight: .medium))
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                
                HStack {
                    if let updated = chart.updated?.start, Calendar.global.isDateInToday(updated) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.accentColor)
                        Text("Walk today")
                            .font(.footnote.weight(.medium))
                            .foregroundColor(.accentColor)
                    } else {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.pink)
                        Text("No walk today")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(.pink)
                    }
                }
                .padding(.bottom, 10)
            }
        }
    }
}
