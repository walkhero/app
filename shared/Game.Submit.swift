import GameKit
import Hero

extension Game {
    func submit(_ challenge: Challenge, _ value: Int) {
        #if !DEBUG
            GKLeaderboard.submitScore(
                value,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: [challenge.leaderboard]) { _ in }
        #endif
    }
}
