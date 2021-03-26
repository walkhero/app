import UIKit

extension UIApplication {
    static let dark = shared.windows.map(\.rootViewController?.traitCollection.userInterfaceStyle).first == .dark
    
    func present(_ controller: UIViewController) {
        guard var root = windows.first?.rootViewController else { return }
        while let presented = root.presentedViewController {
            root = presented
        }
        root.present(controller, animated: true)
    }
}
