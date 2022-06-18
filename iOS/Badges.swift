import SwiftUI
import Hero

struct Badges: View {
    let leaf: Leaf
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(leaf.badges, id: \.name) { badge in
                        HStack {
                            Image(systemName: "leaf.circle.fill")
                                .font(.system(size: 36, weight: .ultraLight))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, badge.name.color)
                            Text(badge.name.title)
                                .font(.callout.weight(.regular))
                            Spacer()
                            Text(badge.squares, format: .number)
                                .font(.callout.monospacedDigit().weight(.light))
                        }
                        .padding(.vertical, 6)
                    }
                } header: {
                    HStack {
                        Text("Badge")
                            .font(.title3.weight(.medium))
                        Spacer()
                        Text("Squares")
                            .font(.title3.weight(.medium))
                    }
                    .foregroundStyle(.secondary)
                }
                .textCase(.none)
            }
            .listStyle(.plain)
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
            .navigationTitle("Badges")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
    }
}
