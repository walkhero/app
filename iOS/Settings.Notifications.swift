import SwiftUI

extension Settings {
    struct Notifications: View {
        @State private var requested = true
        @State private var enabled = true
        
        var body: some View {
            Section("Notifications") {
                Button {
                    if enabled || requested {
                        UIApplication.shared.settings()
                    } else {
                        Task {
                            _ = await UNUserNotificationCenter.request()
                            requested = true
                            await check()
                        }
                    }
                } label: {
                    Option(title: enabled ? "Configure" : "Activate",
                           subtitle: Copy.notifications,
                           symbol: "app.badge")
                }
            }
            .headerProminence(.increased)
            .task {
                await check()
            }
        }
        
        private func check() async {
            let settings = await UNUserNotificationCenter.current().notificationSettings()
            if settings.authorizationStatus == .notDetermined {
                requested = false
                enabled = false
            } else if settings.alertSetting == .disabled || settings.authorizationStatus == .denied {
                enabled = false
            } else {
                enabled = true
            }
        }
    }
}
