import SwiftUI
import Combine
import Hero

extension Map {
    struct Content: View {
        weak var status: Status!
        weak var leaderboards: PassthroughSubject<Void, Never>!
        weak var center: PassthroughSubject<Bool, Never>!
        @State private var walking: TimeInterval?
        @AppStorage(Defaults.follow.rawValue) private var follow = true
        @AppStorage(Defaults.hide.rawValue) private var hidden = true
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            List {
                if let walking = walking {
                    
                } else {
                    Section {
                        Text("Start a walk")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                    } header: {
                        HStack {
                            Spacer()
                            Button {
                                
                            } label: {
                                Image(systemName: "figure.walk.circle.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .font(.largeTitle)
                            }
                            .padding(.top)
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                
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
            .onAppear {
                center.send(Defaults.shouldFollow)
                location.overlays.send(Defaults.shouldHide)
            }
            .onReceive(cloud) {
                walking = $0.walking
            }
        }
    }
}
