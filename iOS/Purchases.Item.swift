import Foundation

extension Purchases {
    enum Item: String, CaseIterable, Codable {
        case
        plus = "walkhero.plus"
        
        var image: String {
            switch self {
            case .plus: return "plus"
            }
        }
        
        var title: String {
            switch self {
            case .plus: return NSLocalizedString("WalkHero+", comment: "")
            }
        }
        
        var subtitle: String {
            switch self {
            case .plus: return NSLocalizedString("""
Support the development of this app.

WalkHero is brought to you by a very small team wanting to make fun and challenging walking to be able to keep up with a healthy lifestyle without having to worry too much about it.

They also wanted to share it with you and others.

Making and maintaining an indie app is not easy, and we appreciate it if your situation allows you contribute for the cause.
""", comment: "")
            }
        }
    }
}
