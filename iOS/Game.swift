import GameKit

final class Game: ObservableObject {
    @Published private(set) var name = "Hero"
    @Published private(set) var image = UIImage()
    
    init() {
        guard !GKLocalPlayer.local.isAuthenticated else {
            load()
            return
        }
        
        GKLocalPlayer.local.authenticateHandler = { [weak self] controller, error in
            guard let controller = controller else {
                if error == nil {
                    self?.load()
                }
                return
            }
            UIApplication.shared.present(controller: controller)
        }
    }
    
    func leaderboard() {
        let controller = GKGameCenterViewController(leaderboardID: Challenge.streak.leaderboard,
                                                    playerScope: .global,
                                                    timeScope: .allTime)
        controller.gameCenterDelegate = UIApplication.shared
        UIApplication.shared.present(controller: controller)
    }
    
    func submit(streak: Int, steps: Int, distance: Int, map: Int) {
#if !DEBUG
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
#endif
    }
    
    private func load() {
        name = GKLocalPlayer.local.displayName
        GKLocalPlayer.local.loadPhoto(for: .normal) { image, _ in
            image.map {
                self.image = $0
            }
        }
    }
}

private extension Challenge {
    var leaderboard: String {
        "\(self)"
    }
}
