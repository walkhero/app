import SwiftUI
import Combine

struct Main: View {
    weak var status: Status!
    @State private var started: Date?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(status: status)
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, started == nil ? 180 : 380)
            
            Options(status: status)
            
            Card(status: status, started: started)
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: started == nil ? 220 : 420)
        }
        .onReceive(cloud) { model in
            withAnimation(.easeInOut(duration: 0.6)) {
                started = model.walking
            }
            
            if let date = started, !status.started {
                status.start(date: date)
            }
        }
    }
}
