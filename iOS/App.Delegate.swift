import UIKit
import StoreKit
import Hero

extension App {
    final class Delegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            Memory.shared.load()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let created = Defaults.created {
                    if !Defaults.rated && Calendar.current.dateComponents([.day], from: created, to: .init()).day! > 4 {
                        Defaults.rated = true
                        SKStoreReviewController.requestReview(in: application.windows.first!.windowScene!)
                    }
                } else {
                    Defaults.created = .init()
                }
            }
            
            return true
        }
    }
}
