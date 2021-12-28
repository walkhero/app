import SwiftUI
import Hero

struct Window: View {
    let status: Status
    @State private var modal: Modal?
    
    var body: some View {
        Navigation(status: status)
            .sheet(item: $modal) {
                switch $0 {
                case .froob:
                    Froob()
                }
            }
            .task {
                switch Defaults.action {
                case .rate:
                    UIApplication.shared.review()
                case .froob:
                    modal = .froob
                case .none:
                    break
                }
            }
    }
}
