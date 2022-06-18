import SwiftUI
import Hero

extension Leaf.Name {
    var title: String {
        "\(self)".capitalized
    }
    
    var color: Color {
        .init("\(self)")
    }
}
