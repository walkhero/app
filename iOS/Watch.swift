import Foundation
import WatchConnectivity
import Combine

final class Watch: NSObject, WCSessionDelegate {
    let challenges = PassthroughSubject<Transport, Never>()

    func activate() {
        guard WCSession.isSupported(),
              WCSession.default.activationState != .activated
        else { return }
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
    
    func session(_: WCSession, didReceiveMessage: [String : Any]) {
        challenges.send(.init(message: didReceiveMessage))
    }
    
    func session(_: WCSession, activationDidCompleteWith: WCSessionActivationState, error: Error?) { }
    func sessionDidBecomeInactive(_: WCSession) { }
    func sessionDidDeactivate(_: WCSession) { }
}
