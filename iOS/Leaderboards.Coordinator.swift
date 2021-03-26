import GameKit
import Combine

extension Leaderboards {
    final class Coordinator: GKGameCenterViewController, GKGameCenterControllerDelegate {
        private var subs = Set<AnyCancellable>()
        
        required init?(coder: NSCoder) { nil }
        
        override init(nibName: String?, bundle: Bundle?) { super.init(nibName: nil, bundle: nil) }
        
        init(wrapper: Leaderboards) {
            super.init(leaderboardID: wrapper.challenge.leaderboard, playerScope: .global, timeScope: .allTime)
            gameCenterDelegate = self
            
            wrapper.session.dismiss.sink { [weak self] in
                self?.dismiss(animated: false)
            }.store(in: &subs)
        }
        
        func gameCenterViewControllerDidFinish(_: GKGameCenterViewController) {
            dismiss(animated: true)
        }
    }
}
