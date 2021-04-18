import GameKit
import Hero

extension Game {
    func submit(_ challenge: Challenge, _ value: Int) {
        guard GKLocalPlayer.local.isAuthenticated else { return }
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
