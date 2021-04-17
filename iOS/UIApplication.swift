import UIKit
import GameKit

extension UIApplication: GKGameCenterControllerDelegate {
    static let dark = shared.windows.map(\.rootViewController?.traitCollection.userInterfaceStyle).first == .dark
    
    private var root: UIViewController? {
        guard var root = windows.first?.rootViewController else { return nil }
        while let presented = root.presentedViewController {
            root = presented
        }
        return root
    }
    
    func settings() {
        open(URL(string: Self.openSettingsURLString)!)
    }
    
    func dismiss() {
        root?.dismiss(animated: false)
    }
    
    func present(_ controller: UIViewController) {
        root?.present(controller, animated: true)
    }
    
    public func gameCenterViewControllerDidFinish(_: GKGameCenterViewController) {
        root?.dismiss(animated: true)
    }
}
