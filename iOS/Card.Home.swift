import SwiftUI

extension Card {
    struct Home: View {
        @State private var stats = false
        @State private var calendar = false
        @State private var settings = false
        
        var body: some View {
            Spacer()
            
            Button {
                Task {
                    await cloud.start()
                    await UNUserNotificationCenter.send(message: "Walk started!")
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.indigo)
                    Text("Start")
                        .font(.body.weight(.medium))
                        .foregroundColor(.white)
                        .padding(25)
                }
                .fixedSize()
                .contentShape(Rectangle())
            }
            
            Spacer()
            
            HStack {
                Option(symbol: "chart.xyaxis.line") {
                    stats = true
                }
                .sheet(isPresented: $stats, content: Stats.init)
                
                Option(symbol: "calendar") {
                    calendar = true
                }
                .sheet(isPresented: $calendar, content: Ephemeris.init)
                
                Option(symbol: "gear") {
                    settings = true
                }
                .sheet(isPresented: $settings, content: Settings.init)
            }
            
            Spacer()
        }
    }
}
