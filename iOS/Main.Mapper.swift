import SwiftUI

extension Main {
    struct Mapper: View {
        @ObservedObject var session: Session
        @StateObject private var map = Map()
        
        var body: some View {
            map
                .safeAreaInset(edge: .top, spacing: 0) {
                    Title(title: "Squares") {
                        Button {
                            map.center()
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .font(.system(size: 26, weight: .light))
                                .symbolRenderingMode(.hierarchical)
                                .frame(width: 36, height: 36)
                                .padding(.trailing)
                                .contentShape(Rectangle())
                        }
                    }
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
