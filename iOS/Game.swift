import GameKit

struct Game {
    func login() {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
        
        GKLocalPlayer.local.authenticateHandler = { controller, _ in
            guard let controller = controller else { return }
            UIApplication.shared.present(controller: controller)
        }
    }
    
    func submit(streak: Int, steps: Int, distance: Int, map: Int) {
        GKLeaderboard.submitScore(
            streak,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.streak.leaderboard]) { _ in }
        
        GKLeaderboard.submitScore(
            steps,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.steps.leaderboard]) { _ in }
        
        GKLeaderboard.submitScore(
            distance,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.distance.leaderboard]) { _ in }
        
        GKLeaderboard.submitScore(
            map,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [Challenge.map.leaderboard]) { _ in }
    }
}

private extension Challenge {
    var leaderboard: String {
        "\(self)"
    }
}
