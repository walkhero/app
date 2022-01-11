import SwiftUI

extension Tools {
    final class Detent: UIHostingController<Content>,
                         UIViewControllerRepresentable,
                         UISheetPresentationControllerDelegate {
        
        required init?(coder: NSCoder) { nil }
        init(status: Status) {
            super.init(rootView: .init(status: status))
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            sheetPresentationController
                .map {
                    $0.detents = [.medium()]
                    $0.largestUndimmedDetentIdentifier = .medium
                }
        }
        
        func makeUIViewController(context: Context) -> Detent {
            self
        }
        
        func updateUIViewController(_: Detent, context: Context) {

        }
    }
}
