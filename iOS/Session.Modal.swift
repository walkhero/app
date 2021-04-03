import Foundation
import Hero

extension Session {
    enum Modal: Identifiable {
        var id: String {
            "\(self)"
        }
        
        case
        challenge(Challenge),
        store
    }
}
