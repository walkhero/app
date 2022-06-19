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
                    Section {
                        VStack {
                            Text("Trend")
                                .font(.title2.weight(.semibold))
                            ZStack {
                                Circle()
                                    .fill(Color(.systemBackground))
                                trend.symbol
                                    .padding(20)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    
                    Section("Average") {
                        Text(average
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .headerProminence(.increased)
                    
                    Section("Max") {
                        Text(max
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .headerProminence(.increased)
                    
                    Section("Total") {
                        Text(total
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .headerProminence(.increased)
                    
                    Section {
                        
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                }
                .listStyle(.insetGrouped)
                .toolbar {
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
