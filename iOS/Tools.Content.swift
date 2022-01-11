import SwiftUI
import Hero

extension Tools {
    struct Content: View {
        @ObservedObject var status: Status
        
        var body: some View {
            NavigationView {
                List {
                    Section {
                        Toggle(isOn: $status.follow) {
                            Text("Follow me")
                                .font(.footnote)
                        }
                        .onChange(of: status.follow) {
                            Defaults.shouldFollow = $0
                        }
                    }
                    
                    Section {
                        Toggle(isOn: $status.hide) {
                            Text("Hide unexplored areas")
                                .font(.footnote)
                        }
                        .onChange(of: status.hide) {
                            Defaults.shouldHide = $0
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .toggleStyle(SwitchToggleStyle(tint: .mint))
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            status.tools = false
                        } label: {
                            Text("Done")
                                .font(.callout.weight(.medium))
                                .padding(.leading)
                                .frame(height: 34)
                                .contentShape(Rectangle())
                                .allowsHitTesting(false)
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}
