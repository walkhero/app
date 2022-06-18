import SwiftUI
import Hero

extension Stats {
    struct Detail: View {
        let title: String
        let trend: Chart.Trend
        let average: AttributedString
        let max: AttributedString
        let total: AttributedString
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            NavigationView {
                List {
                    Section("Average") {
                        Text(average
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .textCase(.none)
                    Section("Max") {
                        Text(max
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .textCase(.none)
                    Section("Total") {
                        Text(total
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .textCase(.none)
                }
                .listStyle(.insetGrouped)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        trend.symbol
                            .padding(4)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 22, weight: .light))
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.secondary)
                                .frame(width: 20, height: 45)
                                .padding(.leading, 25)
                                .contentShape(Rectangle())
                        }
                    }
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
        }
    }
}
