import SwiftUI

struct Navigation: View {
    let status: Status
    
    var body: some View {
        VStack {
            Circle()
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Bar(status: status)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Header(status: status)
        }
    }
}
