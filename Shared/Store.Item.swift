import Foundation
import UserNotifications
import Hero

extension Store {
    enum Item: String, CaseIterable {
        case
        plus = "walkhero.plus"
        
        func purchased(active: Bool) async {
            if active {
                Defaults.isPremium = true
                await UNUserNotificationCenter.send(message: "WalkHero + purchase successful!")
            } else {
                Defaults.isPremium = false
            }
        }
    }
}
