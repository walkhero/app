import GameKit
import Hero

final class Game {
    func login() {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
        GKLocalPlayer.local.authenticateHandler = { _ in }
    }
    
    func submit(_ challenge: Challenge, _ value: Int) {
        guard GKLocalPlayer.local.isAuthenticated else { return }
        print("submit \(challenge) score: \(value)")
        #if !DEBUG
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKLeaderboard.submitScore(
            value,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [challenge.leaderboard]) { _ in }
        #endif
    }
}
