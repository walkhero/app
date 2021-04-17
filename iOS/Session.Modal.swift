import Foundation
import Hero

extension Session {
    enum Modal: Identifiable {
        var id: Self {
            self
        }
        
        case
        store,
        froob
    }
}
