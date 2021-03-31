import SwiftUI

extension Walking {
    struct Time: View {
        @Binding var session: Session
        @State private var indicator = 0
        @State private var counter = ""
        private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            ZStack {
                Clock(indicator: indicator, center: .init(x: 70, y: 2))
                Text(verbatim: counter)
                    .font(Font.callout.bold().monospacedDigit())
            }
            .frame(width: 140, height: 140)
            .onAppear(perform: refresh)
            .onReceive(timer) { _ in
                refresh()
            }
        }
        
        private func refresh() {
            if case let .walking(duration) = session.archive.status {
                withAnimation(.easeInOut(duration: 1)) {
                    self.indicator = .init(duration.truncatingRemainder(dividingBy: 60))
                }
                counter = session.components.string(from: duration) ?? ""
            }
        }
    }

}
