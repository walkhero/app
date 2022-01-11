import SwiftUI

struct Map: UIViewRepresentable {
    weak var status: Status!
    
    func makeUIView(context: Context) -> Representable {
        .init(status: status)
    }
    
    func updateUIView(_: Representable, context: Context) { }
}
