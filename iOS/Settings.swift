import SwiftUI
import CoreLocation

struct Settings: View {
    @State private var store = false
    @State private var about = false
    @State private var notifications = false
    @State private var location = false
    @State private var policy = false
    @State private var terms = false
    
    var body: some View {
        List {
            purchases
            privacy
            app
            help
        }
        .listStyle(.insetGrouped)
        .safeAreaInset(edge: .top, spacing: 0) {
            Main.Title(title: "Settings") {
                EmptyView()
            }
        }
        .task {
            let status = CLLocationManager().authorizationStatus
            location = status != .denied || status != .notDetermined
            
            let settings = await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
            notifications = settings != .notDetermined && settings != .denied
        }
    }
    
    private var purchases: some View {
        Section("In-App Purchases") {
            Item(title: "Walk Hero Plus", symbol: "plus") {
                store = true
            }
//            .sheet(isPresented: $store, content: Purchases.init)
        }
        .headerProminence(.increased)
    }
    
    private var privacy: some View {
        Section("Privacy") {
            Button {
                UIApplication.shared.settings()
            } label: {
                HStack {
                    Text("Notifications")
                        .font(.callout)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: notifications
                          ? "checkmark.circle.fill"
                          : "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 14, weight: .medium))
                    .frame(width: 22)
                    Image(systemName: "app.badge")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 16, weight: .light))
                        .frame(width: 18)
                }
            }
            Button {
                UIApplication.shared.settings()
            } label: {
                HStack {
                    Text("Location")
                        .font(.callout)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: location
                          ? "checkmark.circle.fill"
                          : "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 14, weight: .medium))
                    .frame(width: 22)
                    Image(systemName: "location")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 16, weight: .light))
                        .frame(width: 18)
                }
            }
        }
        .headerProminence(.increased)
    }
    
    private var app: some View {
        Section("Walk Hero") {
            Item(title: "About", symbol: "figure.walk") {
                about = true
            }
            .sheet(isPresented: $about, content: About.init)
            
            Item(title: "Rate on the App Store", symbol: "star") {
                Task {
                    await UIApplication.shared.review()
                }
            }
            
            Link(destination: .init(string: "https://walkhero.github.io/about")!) {
                HStack {
                    Text("walkhero.github.io/about")
                        .foregroundColor(.primary)
                        .font(.callout.weight(.light))
                    
                    Spacer()
                    Image(systemName: "link")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 16, weight: .light))
                        .frame(width: 18)
                }
            }
        }
        .headerProminence(.increased)
    }
    
    private var help: some View {
        Section("Help") {
            Item(title: "Privacy policy", symbol: "hand.raised") {
                policy = true
            }
            .sheet(isPresented: $policy) {
                Info(title: "Privacy Policy", text: Copy.policy)
            }
            
            Item(title: "Terms and conditions", symbol: "doc.plaintext") {
                terms = true
            }
            .sheet(isPresented: $terms) {
                Info(title: "Terms and Conditions", text: Copy.terms)
            }
        }
        .headerProminence(.increased)
    }
}
