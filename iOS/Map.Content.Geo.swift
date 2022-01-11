/*import SwiftUI
import Hero

extension Map.Content {
    struct Geo: View {
        @AppStorage(Defaults.follow.rawValue) private var follow = true
        @AppStorage(Defaults.hide.rawValue) private var hidden = true
        
        var body: some View {
            Section("Map") {
                Toggle(isOn: $follow) {
                    Text("Follow me")
                        .font(.footnote)
                }
                .onChange(of: follow, perform: location.center.send)
                
                Toggle(isOn: $hidden) {
                    Text("Hide unexplored areas")
                        .font(.footnote)
                }
                .onChange(of: hidden, perform: location.overlays.send)
            }
            .toggleStyle(SwitchToggleStyle(tint: .mint))
            .headerProminence(.increased)
            .onAppear {
                location.center.send(Defaults.shouldFollow)
                location.overlays.send(Defaults.shouldHide)
            }
        }
    }
}
*/
