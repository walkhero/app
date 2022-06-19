import SwiftUI

extension Main {
    struct Mapper: View {
        @ObservedObject var session: Session
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
                        .foregroundStyle(Color.accentColor, Color.black)
                        .frame(width: 65, height: 65)
                        .contentShape(Rectangle())
                }
            }.safeAreaInset(edge: .top, spacing: 0) {
                Title(title: "Squares")
            }
            .onChange(of: session.tiles) {
                map.update(overlay: $0.overlay)
            }
            .onAppear {
                map.update(overlay: session.tiles.overlay)
            }
        }
    }

}
