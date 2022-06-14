//import UIKit
//import StoreKit
//import GameKit
//
//extension UIApplication: GKGameCenterControllerDelegate {
//    func settings() {
//        open(URL(string: Self.openSettingsURLString)!)
//    }
//    
//    func review() {
//        scene
//            .map(SKStoreReviewController.requestReview(in:))
//    }
//    
//    func present(controller: UIViewController) {
//        scene?
//            .keyWindow?
//            .rootViewController
//            .map {
//                $0.dismiss(animated: true)
//                controller.popoverPresentationController?.sourceView = $0.view
//                $0.present(controller, animated: true)
//            }
//    }
//    
//    public func gameCenterViewControllerDidFinish(_ controller: GKGameCenterViewController) {
//        controller.dismiss(animated: true)
//    }
//    
//    private var scene: UIWindowScene? {
//        { (connected: [UIWindowScene]) -> UIWindowScene? in
//            connected.count > 1
//            ? connected
//                .filter {
//                    $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive
//                }
//                .first
//            : connected
//                .first
//        } (connectedScenes
//            .compactMap {
//                $0 as? UIWindowScene
//            })
//    }
//}
