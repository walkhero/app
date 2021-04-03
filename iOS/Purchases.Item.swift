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
By purchasing WalkHero+ you are supporting the development of this app.

WalkHero is brought to you by a very small team of walking enthusiasts that wanted to gamificate in order to make fun and challenging walking so that they could keep up with a healthy life style without having to worry too much about it.

They also wanted to share this with you and others.

Making and maintaining an indie game/app is not easy, and we appreciate it if your situation allows you contribute for the cause.
""", comment: "")
            }
        }
    }
}
