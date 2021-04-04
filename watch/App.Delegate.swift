import WatchKit
import Combine
import Hero

extension App {
    final class Delegate: NSObject, WKExtensionDelegate {
        func applicationDidFinishLaunching() {
            WKExtension.shared().registerForRemoteNotifications()
        }
        
        func applicationDidBecomeActive() {
            Memory.shared.pull.send()
        }
        
        func didReceiveRemoteNotification(_: [AnyHashable : Any], fetchCompletionHandler: @escaping (WKBackgroundFetchResult) -> Void) {
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
