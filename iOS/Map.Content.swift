import SwiftUI
import Combine

extension Map {
    struct Content: View {
        weak var status: Status!
        weak var leaderboards: PassthroughSubject<Void, Never>!
        weak var center: PassthroughSubject<Void, Never>!
        @State private var active = true
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            List {
                Section("Map") {
                    Button {
                        center.send()
                    } label: {
                        HStack {
                            Text("Center on my location")
                                .foregroundColor(.primary)
                                .font(.footnote)
                            Spacer()
                            Image(systemName: "location.viewfinder")
                                .symbolRenderingMode(.hierarchical)
                                .font(.title3)
                                .foregroundColor(.mint)
                        }
                        .allowsHitTesting(false)
                    }
                    
                    Toggle(isOn: $active) {
                        Text("Hide unexplored areas")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .mint))
                    .font(.footnote)
                    .onChange(of: active) {
                        location.overlays.send($0)
                    }
                }
                .headerProminence(.increased)
                
                Section("Game Center") {
                    Button {
                        leaderboards.send()
                    } label: {
                        HStack {
                            Text("Leaderboards")
                            Spacer()
                            Image(systemName: "list.star")
                                .symbolRenderingMode(.hierarchical)
                        }
                        .foregroundColor(.primary)
                        .font(.footnote)
                        .allowsHitTesting(false)
                    }
                }
                .headerProminence(.increased)
            }
            .listStyle(.insetGrouped)
            .safeAreaInset(edge: .top, spacing: 0) {
                Header(status: status)
            }
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
            .onReceive(location.overlays) {
                active = $0
            }
        }
    }
}
