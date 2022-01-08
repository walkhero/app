import SwiftUI
import GameKit
import Combine

extension Map {
    final class Options: UIHostingController<Content>, UIViewControllerRepresentable, UISheetPresentationControllerDelegate {
        private var subs = Set<AnyCancellable>()
        
        required init?(coder: NSCoder) { nil }
        init(status: Status) {
            let leaderboards = PassthroughSubject<Void, Never>()
            super.init(rootView: .init(status: status, leaderboards: leaderboards))
            
            leaderboards
                .sink { [weak self] in
                    let controller = GKGameCenterViewController(leaderboardID: Challenge.streak.rawValue,
                                                                playerScope: .global,
                                                                timeScope: .allTime)
                    controller.gameCenterDelegate = UIApplication.shared
                    self?.sheetPresentationController
                        .map { sheet in
                            sheet.animateChanges {
                                sheet.selectedDetentIdentifier = .large
                            }
                            self?.present(controller, animated: true)
                        }
                }
                .store(in: &subs)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            sheetPresentationController
                .map {
                    $0.detents = [.medium(), .large()]
                    $0.largestUndimmedDetentIdentifier = .medium
                    $0.delegate = self
                }
        }
        
        func makeUIViewController(context: Context) -> Options {
            self
        }
        
        func updateUIViewController(_: Options, context: Context) {

        }
        
        func presentationControllerShouldDismiss(_: UIPresentationController) -> Bool {
            false
        }
    }
}
