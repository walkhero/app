import SwiftUI
import Combine

extension Walking {
    struct Time: View {
        @Binding var session: Session
        @State private var indicator = 0
        @State private var counter = ""
        @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            ZStack {
                Clock(indicator: indicator, center: .init(x: 70, y: 2))
                Text(verbatim: counter)
                    .font(.body.bold().monospacedDigit())
            }
            .frame(width: 140, height: 140)
            .onDisappear(perform: stop)
            .onAppear {
                start()
                refresh()
            }
            .onReceive(timer) { _ in
                refresh()
            }
            .onChange(of: phase) {
                switch $0 {
                case .active:
                    start()
                case .inactive:
                    stop()
                default: break
                }
            }
        }
        
        private func start() {
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
        
        private func stop() {
            timer.upstream.connect().cancel()
        }
        
        private func refresh() {
            if case let .walking(duration) = session.archive.status {
                counter = session.components.string(from: duration) ?? ""
                withAnimation(.easeInOut(duration: 1)) {
                    indicator = .init(duration.truncatingRemainder(dividingBy: 60))
                }
            }
        }
    }
}
