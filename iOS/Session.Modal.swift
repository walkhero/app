import Foundation

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
