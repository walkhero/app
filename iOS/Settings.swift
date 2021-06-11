import SwiftUI
import StoreKit
import Hero

struct Settings: View {
    @Binding var session: Session
    @State private var products = [(SKProduct, String)]()
    @State private var error: String?
    @State private var loading = true
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        ScrollView {
            HStack {
                Button {
                    purchases.restore()
                } label: {
                    Text("Restore purchases")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .frame(height: 40)
                        .contentShape(Rectangle())
                }
                .padding(.leading)
                Spacer()
                Button {
                    visible.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .frame(width: 60, height: 40)
                }
                .contentShape(Rectangle())
            }
            .frame(height: 40)
            .padding(.top, 10)
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
                ScrollView {
                    Spacer()
                        .frame(height: 20)
                    if error != nil {
                        Text(verbatim: error!)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    } else if loading {
                        Text("Loading")
                            .bold()
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(products, id: \.0.productIdentifier) { product in
                            Item(purchase: Purchases.Item(rawValue: product.0.productIdentifier)!, price: product.1) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    purchases.purchase(product.0)
                                }
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 20)
                }
                .padding(2)
            }
            .padding(.horizontal)
            Spacer()
                .frame(height: 20)
        }
        .animation(.easeInOut(duration: 0.3))
        .onReceive(session.dismiss) {
            visible.wrappedValue.dismiss()
        }
        .onReceive(purchases.loading) {
            loading = $0
        }
        .onReceive(purchases.error) {
            error = $0
        }
        .onReceive(purchases.products) {
            error = nil
            products = $0
        }
        .onAppear {
            error = nil
            purchases.load()
        }
    }
}
