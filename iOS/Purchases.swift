import SwiftUI
import StoreKit

struct Purchases: View {
    @State private var status = Store.Status.loading
    @State private var product: Product?
    @AppStorage("premium") private var cloud = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 28, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .padding(.trailing, 12)
                        .contentShape(Rectangle())
                }
            }
            .padding(.top, 12)
            
            Image("Plus")
                .padding(.top, 80)
            
            Spacer()
            
            if cloud {
                Text("Walk Hero +")
                    .font(.title.weight(.regular))
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 50, weight: .medium))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.accentColor)
                    .padding(.top, 4)
                Spacer()
            } else {
                switch status {
                case .loading:
                    Image(systemName: "hourglass")
                        .font(.system(size: 40, weight: .ultraLight))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.pink)
                    Spacer()
                case .ready:
                    if let product = product {
                        Text(product.displayName)
                            .font(.title.weight(.regular))
                            .foregroundStyle(.secondary)
                        
                        Text(product.description)
                            .font(.body.weight(.medium))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 220)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Button {
                            Task {
                                await store.purchase(product)
                            }
                        } label: {
                            Text("Get Walk Hero +")
                                .font(.callout.weight(.semibold))
                                .frame(minWidth: 260)
                                .frame(minHeight: 28)
                        }
                        .tint(.accentColor)
                        .foregroundColor(.white)
                        .buttonStyle(.borderedProminent)
                        
                        Text("1 time purchase of " + product.displayPrice)
                            .multilineTextAlignment(.center)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 240)
                        
                        Spacer()
                        
                        Button("Restore Purchases") {
                            Task {
                                await store.restore()
                            }
                        }
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                        .buttonStyle(.plain)
                        .padding(.bottom, 50)
                    }
                case let .error(error):
                    Text(error)
                        .font(.callout.weight(.medium))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 280)
                    Spacer()
                }
            }
        }.onReceive(store.status) {
            status = $0
        }
        .task {
            store.status.value = .loading
            product = await store.load(item: .plus)
            store.status.value = .ready
        }
    }
}
