import SwiftUI

extension Settings {
    struct Info: View {
        let title: String
        let text: String
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            NavigationView {
                ScrollView {
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemBackground))
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                        Text(.init(text))
                            .font(.callout)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 500)
                            .padding(30)
                    }
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
                .background(Color(.secondarySystemBackground))
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
