import SwiftUI
import Combine
import Hero

extension Map {
    struct Content: View {
        weak var status: Status!
        weak var leaderboards: PassthroughSubject<Void, Never>!
        weak var center: PassthroughSubject<Bool, Never>!
        @AppStorage(Defaults.follow.rawValue) private var follow = true
        @AppStorage(Defaults.hide.rawValue) private var hidden = true
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            List {
                Section("Map") {
                    Toggle(isOn: $follow) {
                        Text("Follow me")
                    }
                    .onChange(of: follow) {
                        center.send($0)
                    }
                    
                    Toggle(isOn: $hidden) {
                        Text("Hide unexplored areas")
                    }
                    .onChange(of: hidden) {
                        location.overlays.send($0)
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .mint))
                .font(.footnote)
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
            .onAppear {
                center.send(Defaults.shouldFollow)
                location.overlays.send(Defaults.shouldHide)
            }
        }
    }
}
