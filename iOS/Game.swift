import GameKit
import Combine
import Hero

final class Game {
    let name = PassthroughSubject<String, Never>()
    let image = PassthroughSubject<UIImage, Never>()
    
    func login() {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
        GKLocalPlayer.local.authenticateHandler = { [weak self] controller, error in
            guard let controller = controller else {
                if error == nil {
                    self?.name.send(GKLocalPlayer.local.displayName)
                    GKLocalPlayer.local.loadPhoto(for: .normal) { image, _ in
                        image.map {
                            self?.image.send($0)
                        }
                    }
                }
                return
            }
            UIApplication.shared.present(controller)
        }
    }
    
    func leaderboard(_ challenge: Challenge) {
        let controller = GKGameCenterViewController(leaderboardID: challenge.leaderboard, playerScope: .global, timeScope: .allTime)
        controller.gameCenterDelegate = UIApplication.shared
        UIApplication.shared.present(controller)
    }
    
    func submit(_ challenge: Challenge, _ value: Int) {
        print("challenge: \(challenge) value: \(value)")
        guard GKLocalPlayer.local.isAuthenticated else { return }
        #if !DEBUG
            GKLeaderboard.submitScore(
                value,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: [challenge.leaderboard]) { _ in }
        #endif
    }
}
