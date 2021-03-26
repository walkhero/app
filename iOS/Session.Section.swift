import Foundation
import Hero

extension Session {
    enum Section {
        case
        home,
        listed,
        challenge(Challenge)
    }
}
