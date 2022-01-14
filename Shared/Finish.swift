import Foundation

struct Finish: Identifiable {
    let started: Date
    let steps: Int
    let meters: Int
    let squares: Int
    let streak: Int
    let id = UUID()
}
