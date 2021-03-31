import Foundation
import Hero

struct Session {
    var archive = Archive()
    var player = Player()
    let game = Game()
    let health = Health()
    
//    let location = Location()
    let components = DateComponentsFormatter()
    let decimal = NumberFormatter()
    
    init() {
        components.allowedUnits = [.minute, .second]
        components.unitsStyle = .positional
        components.zeroFormattingBehavior = .pad
        
        decimal.numberStyle = .decimal
    }
}
