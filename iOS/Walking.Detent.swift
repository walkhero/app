import SwiftUI

extension Walking {
    final class Detent: UIHostingController<Content>,
                         UIViewControllerRepresentable,
                         UISheetPresentationControllerDelegate {
        
        required init?(coder: NSCoder) { nil }
        init(status: Status, started: Date) {
            super.init(rootView: .init(status: status, started: started))
            modalPresentationStyle = .overCurrentContext
        }
        
        override func willMove(toParent: UIViewController?) {
            super.willMove(toParent: toParent)
            parent?.modalPresentationStyle = .overCurrentContext
            parent?.view.backgroundColor = .clear
            view.backgroundColor = .clear
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            sheetPresentationController
                .map {
                    $0.detents = [.medium()]
                    $0.largestUndimmedDetentIdentifier = .medium
                    $0.delegate = self
                }
        }
        
        func makeUIViewController(context: Context) -> Detent {
            self
        }
        
        func updateUIViewController(_: Detent, context: Context) {

        }
        
        func presentationControllerShouldDismiss(_: UIPresentationController) -> Bool {
            false
        }
    }
}
