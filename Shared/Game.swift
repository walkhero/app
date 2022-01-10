import GameKit

struct Game {
#if os(iOS)
    func login(status: Status) {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
        GKLocalPlayer.local.authenticateHandler = { controller, error in
            guard let controller = controller else {
                if error == nil {
                    status.name = GKLocalPlayer.local.displayName
                    GKLocalPlayer.local.loadPhoto(for: .normal) { image, _ in
                        image
                            .map {
                                status.image = $0
                            }
                    }
                }
                return
            }
            UIApplication.shared.present(controller: controller)
        }
    }
#endif
    
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
