import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationView {
            List {
                Section("Personalize") {
                    Button {
                        
                    } label: {
                        Option(title: "Location",
                               subtitle: "Accurately keep track of the Moon",
                               symbol: "location")
                    }
//                    .sheet(isPresented: $location, content: Location.init)
                    
                }
                .headerProminence(.increased)
                
                Notifications()
                
                Section("Walk Hero") {
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
        }
        .navigationViewStyle(.stack)
    }
}
