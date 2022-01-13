import SwiftUI

struct Main: View {
    weak var status: Status!
    @State private var finish: Finish?
    @State private var started: Date?
    
    var body: some View {
        ZStack {
            if let finish = finish {
                Confirm(finish: finish) {
                    self.finish = nil
                }
            } else if let started = started {
                Walking(status: status,
                        finish: $finish,
                        started: started)
            } else {
                TabView {
                    Home()
                    Stats()
                }
            }
        }
        .animation(.easeInOut(duration: 0.7), value: started)
        .onReceive(cloud) { model in
            started = model.walking
            
            if let date = started, !status.started {
                Task {
                    await status.start(date: date)
                }
            }
        }
    }
}
