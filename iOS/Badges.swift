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
                            ZStack {
                                Circle()
                                    .fill(Color.accentColor)
                                    .padding(2.5)
                                Image(systemName: "leaf.circle.fill")
                                    .font(.system(size: 45, weight: .ultraLight))
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.black, badge.name.color)
                            }
                            .fixedSize()
                            
                            Text(badge.name.title)
                                .font(.callout.weight(.medium))
                            
                            Spacer()
                            
                            ZStack(alignment: .trailing) {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(Color.accentColor.opacity(0.3))
                                    .frame(width: 90, height: 36)
                                Text(badge.squares, format: .number)
                                    .font(.system(size: 16, weight: .regular).monospacedDigit())
                                    .padding(.trailing, 12)
                            }
                        }
                        .padding(.vertical, 3)
                    }
                } header: {
                    HStack {
                        Text("Badge")
                            .font(.callout.weight(.medium))
                        Spacer()
                        Text("Squares")
                            .font(.body.weight(.medium))
                    }
                    .foregroundColor(.accentColor)
                    .padding(.vertical, 8)
                }
                .textCase(.none)
                
                Section {
                    
                }
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
