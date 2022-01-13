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
                        .fill(Color.accentColor.opacity(0.15))
                    Circle()
                        .fill(Color.accentColor)
                        .padding(3)
                    Text("Start")
                        .font(.body.weight(.medium))
                        .foregroundColor(.white)
                        .padding(28)
                }
                .fixedSize()
                .contentShape(Rectangle())
            }
            
            Spacer()
            
            HStack {
                Option(font: .title2.weight(.light), symbol: "calendar") {
                    calendar = true
                }
                .sheet(isPresented: $calendar, content: Ephemeris.init)
                
                Option(font: .largeTitle.weight(.light), symbol: "chart.line.uptrend.xyaxis.circle") {
                    stats = true
                }
                .sheet(isPresented: $stats, content: Stats.init)
                
                Option(font: .title2.weight(.light), symbol: "gear") {
                    settings = true
                }
                .sheet(isPresented: $settings, content: Settings.init)
            }
            
            Spacer()
        }
    }
}
