import StoreKit
import UserNotifications
import Combine
import Hero

final actor Store {
    enum Status: Equatable {
        case
        loading,
        ready,
        error(String)
    }
    
    enum Item: String, CaseIterable {
        case
        plus = "walkhero.plus"
        
        func purchased(active: Bool) async {
            if active {
                Defaults.isPremium = true
                await UNUserNotificationCenter.send(message: "Walk Sponsor purchase successful!")
            } else {
                Defaults.isPremium = false
            }
        }
    }
    
    nonisolated let status = CurrentValueSubject<Status, Never>(.ready)
    private var products = [Item : Product]()
    private var restored = false
    
    func launch() async {
        for await result in Transaction.updates {
            if case let .verified(safe) = result {
                await process(transaction: safe)
            }
        }
    }
    
    func load(item: Item) async -> Product? {
        guard let product = products[item] else {
            guard let product = try? await Product.products(for: [item.rawValue]).first else { return nil }
            products[item] = product
            return product
        }
        return product
    }
    
    func purchase(_ product: Product) async {
        status.send(.loading)

        do {
            switch try await product.purchase() {
            case let .success(verification):
                if case let .verified(safe) = verification {
                    await process(transaction: safe)
                    status.send(.ready)
                } else {
                    status.send(.error("Purchase verification failed."))
                }
            case .pending:
                status.send(.ready)
                await UNUserNotificationCenter.send(message: "Purchase is pending...")
            default:
                status.send(.ready)
            }
        } catch let error {
            status.send(.error(error.localizedDescription))
        }
    }
    
    func restore() async {
        status.send(.loading)
        
        if restored {
            try? await AppStore.sync()
        }
        
        for await result in Transaction.currentEntitlements {
            if case let .verified(safe) = result {
                await process(transaction: safe)
            }
        }
        
        status.send(.ready)
        restored = true
    }
    
    func purchase(legacy: SKProduct) async {
        guard let product = try? await Product.products(for: [legacy.productIdentifier]).first else { return }
        await purchase(product)
    }
    
    private func process(transaction: Transaction) async {
        guard let item = Item(rawValue: transaction.productID) else { return }
        await item.purchased(active: transaction.revocationDate == nil)
        await transaction.finish()
    }
}
