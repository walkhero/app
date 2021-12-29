import SwiftUI

extension Map.Bar {
    final class Layers: UIHostingController<Content>, UIViewControllerRepresentable {
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            sheetPresentationController
                .map {
                    $0.detents = [.medium()]
                }
        }
        
        func makeUIViewController(context: Context) -> Layers {
            self
        }
        
        func updateUIViewController(_: Layers, context: Context) {

        }
    }
}
