import SwiftUI

extension Main {
    struct Mapper: View {
        @StateObject private var map = Map()
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                map
                Button {
                    map.center()
                } label: {
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 30, weight: .ultraLight))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color(.systemBackground), Color.primary)
                        .frame(width: 65, height: 65)
                        .contentShape(Rectangle())
                }
            }.safeAreaInset(edge: .top, spacing: 0) {
                Divider()
                    .background(.ultraThinMaterial)
            }
//                .onChange(of: walker.overlay) {
//                    map.update(overlay: $0)
//                }
//                .onAppear {
//                    map.update(overlay: walker.overlay)
//                }
        }
    }

}
