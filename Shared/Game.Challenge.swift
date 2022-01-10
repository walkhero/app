import Foundation

enum Challenge: String {
    case
    streak,
    steps,
    distance,
    map
    
    var leaderboard: String {
        "\(self)"
    }
}
