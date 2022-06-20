import SwiftUI

extension Settings {
    struct Item: View {
        let title: String
        let symbol: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                HStack {
                    Text(title)
                        .font(.callout)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: symbol)
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 16, weight: .light))
                        .frame(width: 18)
                }
            }
        }
    }
}
