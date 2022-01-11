import SwiftUI

struct Card: View {
    @ObservedObject var status: Status
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.tertiarySystemBackground))
            VStack {
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
                            .font(.callout)
                            .foregroundColor(.white)
                    }
                    .frame(width: 80, height: 80)
                    .contentShape(Rectangle())
                }
                .padding(.bottom)
                
                HStack {
                    Option(symbol: "chart.xyaxis.line") {
                        
                    }
                    
                    Option(symbol: "calendar") {
                        
                    }
                    
                    Option(symbol: "gear") {
                        
                    }
                }
                .padding(.top)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 260)
        .sheet(isPresented: $status.tools) {
            Tools.Detent(status: status)
                .equatable()
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
