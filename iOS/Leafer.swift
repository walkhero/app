import SwiftUI
import Hero

struct Leafer: View {
    let leaf: Leaf
    
    var body: some View {
        Image(systemName: "leaf.circle.fill")
            .font(.system(size: 30, weight: .ultraLight))
            .symbolRenderingMode(.hierarchical)
    }
}
