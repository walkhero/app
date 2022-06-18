import SwiftUI
import Hero

extension Stats {
    struct Streak: View {
        let streak: Hero.Streak
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            NavigationView {
                List {
                    Section("Current") {
                        Text(.days(value: streak.current)
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .headerProminence(.increased)
                    
                    Section("Max") {
                        Text(.days(value: streak.max)
                            .numeric(font: .title3.monospacedDigit().weight(.regular),
                                     color: .primary))
                            .font(.footnote.weight(.regular))
                            .foregroundColor(.secondary)
                    }
                    .headerProminence(.increased)
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
                .navigationTitle("Streak")
                .navigationBarTitleDisplayMode(.large)
            }
            .navigationViewStyle(.stack)
        }
    }
}
