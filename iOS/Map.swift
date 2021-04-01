import SwiftUI
import Combine
import Hero

struct Map: UIViewRepresentable {
    @Binding var session: Session
    let tiles: Set<Tile>
    let add: PassthroughSubject<Set<Tile>, Never>?
    
    func makeCoordinator() -> Coordinator {
        .init(wrapper: self)
    }
    
    func makeUIView(context: Context) -> Coordinator {
        context.coordinator
    }
    
    func updateUIView(_: Coordinator, context: Context) { }
}
