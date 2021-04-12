import SwiftUI
import Hero

struct Map: UIViewRepresentable {
    @Binding var session: Session
    let tiles: Set<Tile>
    
    func makeCoordinator() -> Coordinator {
        .init(wrapper: self)
    }
    
    func makeUIView(context: Context) -> Coordinator {
        context.coordinator
    }
    
    func updateUIView(_ coordinator: Coordinator, context: Context) {
        coordinator.tiles.send(tiles)
    }
}
