import GameKit
import Combine
import Hero

final class Game {
    let name = PassthroughSubject<String, Never>()
    
    func login() {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
        GKLocalPlayer.local.authenticateHandler = { [weak self] error in
            if error == nil {
                self?.name.send(GKLocalPlayer.local.displayName)
            }
        }
    }
    
    func submit(_ challenge: Challenge, _ value: Int) {
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKLeaderboard.submitScore(
            value,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [challenge.leaderboard]) { _ in }
    }
}
