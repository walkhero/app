import SwiftUI

extension Card {
    struct Option: View {
        let symbol: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Image(systemName: symbol)
                    .font(.title3)
                    .allowsHitTesting(false)
            }
            .frame(width: 50, height: 50)
        }
    }
}
