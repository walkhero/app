import Foundation

struct Transport {
    var message: [String : Any] {
        [Challenge.streak.rawValue : streak,
         Challenge.steps.rawValue : steps,
         Challenge.distance.rawValue : distance,
         Challenge.map.rawValue : map]
    }
    
    let streak: Int
    let steps: Int
    let distance: Int
    let map: Int
    
    init(streak: Int, steps: Int, distance: Int, map: Int) {
        self.streak = streak
        self.steps = steps
        self.distance = distance
        self.map = map
    }
    
    init(message: [String : Any]) {
        self.streak = message[.streak]
        self.steps = message[.steps]
        self.distance = message[.distance]
        self.map = message[.map]
    }
}

private enum Challenge: String {
    case
    streak,
    steps,
    distance,
    map
}

private extension Dictionary where Key == String, Value == Any {
    subscript(_ key: Challenge) -> Int {
        self[key.rawValue] as? Int ?? 0
    }
}
