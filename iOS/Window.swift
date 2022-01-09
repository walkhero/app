import SwiftUI
import Hero

struct Window: View {
    let status: Status
    
    var body: some View {
        Map(status: status)
            .task {
                switch Defaults.action {
                case .rate:
                    UIApplication.shared.review()
                case .froob:
                    status.froob = true
                case .none:
                    break
                }
                
                _ = await UNUserNotificationCenter.request()
            }
    }
}
