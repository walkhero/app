import SwiftUI
import Combine

struct Main: View {
    weak var status: Status!
    @State private var started: Date?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(status: status)
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, started == nil ? 180 : 320)
            
            Options(status: status)
            
            Card(status: status, started: started)
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: started == nil ? 260 : 430)
                .offset(y: 40)
        }
        .onReceive(cloud) { model in
            let walking = model.walking
            withAnimation(.easeInOut(duration: 0.4)) {
                started = walking
            }
            
            if let date = walking {
                Task {
                    await status.start(date: date)
                }
            } else if status.started {
                Task {
                    await status.cancel()
                }
            }
        }
    }
}
