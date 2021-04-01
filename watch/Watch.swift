import Foundation
import WatchConnectivity

final class Watch: NSObject, WCSessionDelegate {
    func send(_ transport: Transport) {
        guard WCSession.isSupported(),
              WCSession.default.activationState == .activated,
              WCSession.default.isReachable,
              WCSession.default.isCompanionAppInstalled
        else { return }
        WCSession.default.sendMessage(transport.message, replyHandler: nil, errorHandler: nil)
    }
    
    func session(_: WCSession, activationDidCompleteWith: WCSessionActivationState, error: Error?) { }
    func session(_: WCSession, didReceiveApplicationContext: [String: Any]) { }
}
