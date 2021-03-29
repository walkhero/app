import SwiftUI

struct Map: UIViewRepresentable {
    @Binding var session: Session
    
    func makeCoordinator() -> Coordinator {
        .init(wrapper: self)
    }
    
    func makeUIView(context: Context) -> Coordinator {
        context.coordinator
    }
    
    func updateUIView(_: Coordinator, context: Context) { }
}
