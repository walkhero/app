import SwiftUI
import Hero

struct Map: UIViewRepresentable {
    let tiles: Set<Tile>
    let follow: Bool
    
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    func makeUIView(context: Context) -> Coordinator {
        context.coordinator
    }
    
    func updateUIView(_ coordinator: Coordinator, context: Context) {
        coordinator.tiles.send(tiles)
        coordinator.follow = follow
    }
}
