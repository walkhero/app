import UIKit
import StoreKit
import Combine
import Hero

extension App {
    final class Delegate: NSObject, UIApplicationDelegate {
        let froob = PassthroughSubject<Void, Never>()
        private var sub: AnyCancellable?
        
        func application(_ application: UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            application.registerForRemoteNotifications()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                if let created = Defaults.created {
                    let days = Calendar.current.dateComponents([.day], from: created, to: .init()).day!
                    if !Defaults.rated && days > 4 {
                        Defaults.rated = true
                        SKStoreReviewController.requestReview(in: application.windows.first!.windowScene!)
                    } else if Defaults.rated && !Defaults.plus {
                        if days > 6 {
                            self?.froob.send()
                        }
                    }
                } else {
                    Defaults.created = .init()
                }
            }
            
            return true
        }
        
        func application(_: UIApplication, didReceiveRemoteNotification: [AnyHashable : Any], fetchCompletionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            sub = Memory
                    .shared
                    .receipt
                    .sink {
                        fetchCompletionHandler($0 ? .newData : .noData)
                    }
        }
    }
}
