import SwiftUI
import Combine

extension Walking {
    struct Steps: View {
        @Binding var session: Session
        let steps: Int
        let maximum: Int
        @State private var display = 0
        @State private var counter = 0
        @State private var delta = 0
        @State private var a = CGFloat()
        @State private var b = CGFloat()
        @State private var c = CGFloat()
        @State private var d = CGFloat()
        @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            ZStack {
                Text("STEPS")
                    .font(.footnote)
                    .padding([.leading, .top])
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                Water(percent: .init(display % maximum) / .init(maximum), a: a, b: b)
                    .fill(LinearGradient(
                            gradient: .init(colors: [.blue, .purple]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .opacity(0.5)
                    .mask(Circle())
                    .padding(Metrics.steps.padding)
                Water(percent: .init(display % maximum) / .init(maximum), a: c, b: d)
                    .fill(LinearGradient(
                            gradient: .init(colors: [.blue, .purple]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .scaleEffect(CGSize(width: -1.0, height: 1.0))
                    .opacity(0.5)
                    .mask(Circle())
                    .padding(Metrics.steps.padding)
                Circle()
                    .stroke(Color.blue, lineWidth: 4)
                    .padding(Metrics.steps.padding)
                VStack {
                    Text(NSNumber(value: counter), formatter: session.decimal)
                        .font(.title.bold())
                    if maximum > Metrics.steps.min {
                        Text(NSNumber(value: maximum), formatter: session.decimal)
                            .foregroundColor(.secondary)
                        if steps > maximum {
                            Group {
                                Text(NSNumber(value: steps / maximum), formatter: session.decimal) +
                                Text(verbatim: "x")
                            }
                            .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onChange(of: steps) { _ in
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
            delta = max((steps - display) / 10, 1)
            a = random
            b = random
            c = random
            d = random
            withAnimation(.easeInOut(duration: 1)) {
                display = steps
            }
        }
        
        private var random: CGFloat {
            .random(in: 1 ..< 35)
        }
    }
}
