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
    
    func present(_ controller: UIViewController) {
        root?.present(controller, animated: true)
    }
    
    func settings() {
        open(URL(string: Self.openSettingsURLString)!)
    }
    
    public func gameCenterViewControllerDidFinish(_: GKGameCenterViewController) {
        root?.dismiss(animated: true)
    }
}
