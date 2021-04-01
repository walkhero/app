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
        private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            VStack {
                Text("DISTANCE")
                    .font(.footnote)
                    .padding(.leading)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.blue.opacity(0.2), lineWidth: 6)
                    Ring(percent: .init(display % maximum) / .init(maximum))
                        .stroke(LinearGradient(
                                    gradient: .init(colors: [.purple, .blue]),
                                    startPoint: .top,
                                    endPoint: .bottom),
                                style: .init(lineWidth: 6,
                                             lineCap: .round))
                    VStack {
                        if metres > 0 {
                            Text(Measurement(value: .init(metres), unit: UnitLength.meters), formatter: session.measures)
                                .font(Font.callout.bold())
                        } else {
                            Text("STARTING")
                                .font(.caption2)
                        }
                        if maximum > Metrics.distance.min {
                            Text(NSNumber(value: maximum), formatter: session.decimal)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            if metres > maximum {
                                Group {
                                    Text(NSNumber(value: metres / maximum), formatter: session.decimal) +
                                    Text(verbatim: "x")
                                }
                                .font(Font.footnote.bold())
                                .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
                .frame(width: 130, height: 130)
            }
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
            .onAppear(perform: refresh)
        }
        
        private func refresh() {
            delta = max((metres - display) / 10, 1)
            withAnimation(.easeInOut(duration: 1)) {
                display = metres
            }
        }
    }
}
