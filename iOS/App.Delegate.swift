import UIKit
import StoreKit
import Combine
import Hero

extension App {
    final class Delegate: NSObject, UIApplicationDelegate {
        let froob = PassthroughSubject<Void, Never>()
        
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
            Memory.shared.pull.send()
        }
    }
}
