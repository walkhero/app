import SwiftUI
import Hero

struct Main: View {
    weak var status: Status!
    @State private var summary: Summary?
    @State private var loading = true
    @State private var started = UInt32()
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            if loading {
                Image(systemName: "figure.walk")
                    .font(.largeTitle.weight(.light))
                    .foregroundStyle(.tertiary)
            } else if let result = summary {
                Confirm(summary: result) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        summary = nil
                    }
                }
            } else if started > 0 {
                Walking(status: status,
                        summary: $summary,
                        started: started)
            } else {
                TabView(selection: $selection) {
                    Home()
                    Stats()
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: started)
        .onAppear {
            cloud.ready.notify(queue: .main) {
                loading = false
            }
        }
        .onReceive(cloud) { model in
            started = model.walking
            
            if started > 0 {
                Task {
                    await status.start(date: .init(timestamp: started))
                }
            } else if status.started {
                Task {
                    await status.cancel()
                }
            }
        }
    }
}
