import SwiftUI
import Hero

extension Settings {
    struct Item: View {
        let purchase: Purchases.Item
        let price: String
        let action: () -> Void
        @AppStorage(Defaults.Key.plus.rawValue) private var plus = false
        
        var body: some View {
            Image(purchase.image)
                .padding(.top, 30)
            Text(verbatim: purchase.subtitle)
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            Text(verbatim: purchase.title)
                .font(.largeTitle)
                .padding(.top)
            Text(verbatim: price)
                .font(.callout)
            if plus {
                Image(systemName: "checkmark.seal.fill")
                    .font(.largeTitle)
                    .padding(.vertical)
            } else {
                Button(action: action) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor)
                        Text("Purchase")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude)
                }
                .padding(.horizontal, 20)
                .padding(.bottom)
            }
        }
    }
}
