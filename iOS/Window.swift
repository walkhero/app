import SwiftUI
import Hero

struct Window: View {
    let status: Status
    @StateObject private var health = Health()
    
    var body: some View {
        Map(status: status, health: health)
            .task {
                switch Defaults.action {
                case .rate:
                    UIApplication.shared.review()
                case .froob:
                    DispatchQueue
                        .main
                        .asyncAfter(deadline: .now() + 1) {
                            status.froob = true
                        }
                case .none:
                    break
                }
                
                location.request()
                await health.request()
                _ = await UNUserNotificationCenter.request()
                
                await cloud.migrate(directory: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
            }
    }
}
