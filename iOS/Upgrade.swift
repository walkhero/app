import SwiftUI
import StoreKit

struct Upgrade: View {
    @State private var loading = false
    @State private var alert = false
    @State private var error = ""
    @State private var product: Product?
    
    var body: some View {
        VStack {
            if loading {
                Image(systemName: "clock")
                    .font(.system(size: 30, weight: .light))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.secondary)
            } else {
                Text("Support the\ndevelopment of Walk.")
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                Button {
                    if let product = product {
                        Task {
                            await store.purchase(product)
                        }
                    } else {
                        error = "Unable to connect to the App Store, try again later."
                        alert = true
                    }
                } label: {
                    Text("Sponsor Walk")
                        .font(.callout.weight(.medium))
                        .padding(.horizontal)
                        .frame(minHeight: 28)
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .foregroundColor(.white)
                
                if let product = product {
                    Text("1 time purchase of " + product.displayPrice)
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 240)
                }
            }
        }
        .padding(.vertical, 12)
        .modifier(Card())
        .alert(error, isPresented: $alert) { }
        .onReceive(store.status) {
            switch $0 {
            case .loading:
                loading = true
                alert = false
                error = ""
            case .ready:
                alert = false
                loading = false
                error = ""
            case let .error(fail):
                error = fail
                loading = false
                alert = true
            }
        }
        .task {
            product = await store.load(item: .plus)
        }
    }
}
