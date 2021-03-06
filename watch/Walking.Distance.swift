import SwiftUI
import Combine

extension Walking {
    struct Distance: View {
        @Binding var session: Session
        let metres: Int
        let maximum: Int
        @State private var display = 0
        @State private var counter = 0
        @State private var delta = 0
        @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            ZStack {
                Text("DISTANCE")
                    .font(.footnote)
                    .padding([.leading, .top])
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                Circle()
                    .stroke(Color.blue.opacity(0.2), lineWidth: 12)
                    .padding(Metrics.distance.padding)
                Ring(percent: .init(display % maximum) / .init(maximum))
                    .stroke(LinearGradient(
                                gradient: .init(colors: [.purple, .blue]),
                                startPoint: .top,
                                endPoint: .bottom),
                            style: .init(lineWidth: 12,
                                         lineCap: .round))
                    .padding(Metrics.distance.padding)
                VStack {
                    Text(Measurement(value: .init(metres), unit: UnitLength.meters), formatter: session.measures)
                        .font(.title2.bold())
                    if maximum > Metrics.distance.min {
                        Text(Measurement(value: .init(maximum), unit: UnitLength.meters), formatter: session.measures)
                            .foregroundColor(.secondary)
                        if metres > maximum {
                            Group {
                                Text(NSNumber(value: metres / maximum), formatter: session.decimal) +
                                Text(verbatim: "x")
                            }
                            .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onChange(of: metres) { _ in
                refresh()
            }
            .onReceive(timer) { _ in
                if counter < display {
                    counter += delta
                } else if counter > display {
                    counter = display
                }
            }
            .onDisappear(perform: stop)
            .onAppear {
                start()
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
            delta = max((metres - display) / 10, 1)
            withAnimation(.easeInOut(duration: 1)) {
                display = metres
            }
        }
    }
}
