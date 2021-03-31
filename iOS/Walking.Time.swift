import SwiftUI

extension Walking {
    struct Time: View {
        @Binding var session: Session
        @State private var indicator = 0
        @State private var counter = ""
        private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            Spacer()
            ZStack {
                Clock(indicator: indicator, center: .init(x: 80, y: 2))
                VStack {
                    Image(systemName: "figure.walk")
                        .font(.title2)
                    Text(verbatim: counter)
                        .font(Font.title3.bold().monospacedDigit())
                }
            }
            .frame(width: 160, height: 160)
            Spacer()
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
