import UIKit
import StoreKit
import Combine
import Hero

extension App {
    final class Delegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            application.registerForRemoteNotifications()
            
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
        
        func application(_: UIApplication, didReceiveRemoteNotification: [AnyHashable : Any], fetchCompletionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            var sub: AnyCancellable?
            sub = Memory.shared.archive
                .timeout(.seconds(20), scheduler: DispatchQueue.global(qos: .utility))
                .sink { _ in
                    fetchCompletionHandler(.noData)
                    sub?.cancel()
                } receiveValue: { _ in
                    fetchCompletionHandler(.newData)
                    sub?.cancel()
                }
            Memory.shared.fetch()
        }
    }
}
