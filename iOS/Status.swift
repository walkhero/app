import UIKit

final class Status: ObservableObject {
    @Published var name = "Hero"
    @Published var image: UIImage?
}
