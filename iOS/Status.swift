import UIKit

final class Status: ObservableObject {
    @Published var name = "hello"
    @Published var image: UIImage?
}
