import UIKit
import StoreKit
import Combine
import WidgetKit
import Hero

extension App {
    final class Delegate: NSObject, UIApplicationDelegate {
        let froob = PassthroughSubject<Void, Never>()
        private var widget: AnyCancellable?
        private var fetch: AnyCancellable?
        
        func application(_ application: UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            application.registerForRemoteNotifications()
            
            widget = Repository.memory
                        .archive
                        .merge(with: Repository.memory.save)
                        .removeDuplicates()
                        .debounce(for: .seconds(3), scheduler: DispatchQueue.global(qos: .utility))
                                .sink {
                                    Defaults.archive = $0
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
            
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
            fetch = Repository
                    .memory
                    .receipt
                    .sink {
                        fetchCompletionHandler($0 ? .newData : .noData)
                    }
        }
    }
}
