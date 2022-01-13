import SwiftUI

extension Card {
    struct Option: View {
        let font: Font
        let symbol: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Image(systemName: symbol)
                    .font(font)
                    .allowsHitTesting(false)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.secondary)
            }
            .frame(width: 50, height: 50)
        }
    }
}
