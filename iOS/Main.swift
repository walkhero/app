import SwiftUI
import Hero

struct Main: View {
//    let status: Status
    @State private var started = UInt32()
    @State private var loading = true
    
    var body: some View {
        ScrollView {
            if loading {
                
            } else {
                
            }
            Text("hello")
            Spacer()
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color(.secondarySystemBackground))
        .safeAreaInset(edge: .bottom, spacing: 0) {
            
        }
        .task {
            cloud.ready.notify(queue: .main) {
                loading = false
            }
        }
        .onReceive(cloud) { model in
            withAnimation(.easeInOut(duration: 0.3)) {
                started = model.walking
            }

//            if model.walking > 0 {
//                Task {
//                    await status.start(date: .init(timestamp: model.walking))
//                }
//            } else if status.started {
//                Task {
//                    await status.cancel()
//                }
//            }
        }
        
//        ZStack(alignment: .bottom) {
//            Map(status: status)
//                .edgesIgnoringSafeArea(.top)
//                .padding(.bottom, started == nil ? 180 : 320)
//
//            Options(status: status)
//
//            Card(status: status, started: started)
//                .edgesIgnoringSafeArea(.bottom)
//                .frame(height: started == nil ? 260 : 430)
//                .offset(y: 40)
//        }
    }
}
