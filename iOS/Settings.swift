import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("Location") {
                    Button {
                        UIApplication.shared.settings()
                    } label: {
                        Option(title: "Configure",
                               subtitle: "Map the areas where you walk",
                               symbol: "location")
                    }
                }
                .headerProminence(.increased)
                
                Notifications()
                
                Section("Walk Hero") {
                    NavigationLink(destination: Plus()) {
                        Option(title: "Walk Hero +",
                               subtitle: "Support Walk Hero",
                               symbol: "plus")
                    }
                    
                    NavigationLink(destination: About()) {
                        Option(title: "About",
                               subtitle: "App details",
                               symbol: "figure.walk")
                    }
                    
                    NavigationLink(destination: Info(title: "Privacy policy", text: Copy.privacy)) {
                        Option(title: "Privacy policy",
                               subtitle: "What we do with your data",
                               symbol: "hand.raised")
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.callout.weight(.medium))
                            .padding(.leading)
                            .frame(height: 34)
                            .contentShape(Rectangle())
                            .allowsHitTesting(false)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
