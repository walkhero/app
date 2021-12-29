import SwiftUI

extension Map.Bar {
    struct Content: View {
        @State private var active = true
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            NavigationView {
                List {
                    Toggle(isOn: $active) {
                        Text("Hide unexplored areas")
                    }
                    .onChange(of: active) {
                        location.overlays.send($0)
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .mint))
                .font(.callout)
                .imageScale(.large)
                .symbolRenderingMode(.multicolor)
                .listStyle(.plain)
                .navigationTitle("Configure")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .font(.callout)
                                .padding(.leading)
                                .frame(height: 34)
                                .allowsHitTesting(false)
                                .contentShape(Rectangle())
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
            .onReceive(location.overlays) {
                active = $0
            }
        }
    }
}
