import UIKit

final class Status: ObservableObject {
    @Published var name = "Hero"
    @Published var image: UIImage?
    @Published var froob = false
    let components = DateComponentsFormatter()
    
    init() {
        components.allowedUnits = [.minute, .second]
        components.unitsStyle = .positional
        components.zeroFormattingBehavior = .pad
    }
}
