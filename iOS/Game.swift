import GameKit

struct Game {
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
