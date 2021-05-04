import SwiftUI
import Combine

extension Walking {
    struct Steps: View {
        @Binding var session: Session
        @Binding var steps: Int
        let maximum: Int
        @State private var display = 0
        @State private var counter = 0
        @State private var delta = 0
        @State private var a = CGFloat()
        @State private var b = CGFloat()
        @State private var c = CGFloat()
        @State private var d = CGFloat()
        private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            Text("STEPS")
                .font(.headline)
                .padding(.top)
            Spacer()
            ZStack {
                Water(percent: .init(display % maximum) / .init(maximum), a: a, b: b)
                    .fill(LinearGradient(
                            gradient: .init(colors: [.blue, .init(.systemIndigo)]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .opacity(0.5)
                    .mask(Circle())
                Water(percent: .init(display % maximum) / .init(maximum), a: c, b: d)
                    .fill(LinearGradient(
                            gradient: .init(colors: [.blue, .init(.systemIndigo)]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .scaleEffect(.init(width: -1.0, height: 1.0))
                    .opacity(0.5)
                    .mask(Circle())
                Circle()
                    .stroke(Color.blue, lineWidth: 6)
                VStack {
                    Text(NSNumber(value: counter), formatter: session.decimal)
                        .font(.largeTitle.bold())
                        .padding(.horizontal)
                    if maximum > Metrics.steps.min {
                        Text(NSNumber(value: maximum), formatter: session.decimal)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        if steps > maximum {
                            Group {
                                Text(NSNumber(value: steps / maximum), formatter: session.decimal) +
                                Text(verbatim: "x")
                            }
                            .font(.title.bold())
                            .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .frame(width: 250, height: 250)
            Spacer()
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
                .onAppear(perform: refresh)
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
            .random(in: 1 ..< 75)
        }
    }
}
