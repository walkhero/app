import SwiftUI
import Combine

extension Walking {
    struct Distance: View {
        @Binding var session: Session
        @Binding var metres: Int
        let maximum: Int
        @State private var display = 0
        @State private var counter = 0
        @State private var delta = 0
        private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            Text("DISTANCE")
                .font(.headline)
            Spacer()
            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(0.2), lineWidth: 25)
                Ring(percent: .init(display % maximum) / .init(maximum))
                    .stroke(LinearGradient(
                                gradient: .init(colors: [.init(.systemIndigo), .blue]),
                                startPoint: .top,
                                endPoint: .bottom),
                            style: .init(lineWidth: 25,
                                         lineCap: .round))
                VStack {
                    if metres > 0 {
                        Text(Measurement(value: .init(metres), unit: UnitLength.meters), formatter: session.measures)
                            .font(Font.title3.bold())
                            .padding(.horizontal)
                    } else {
                        Text("STARTING")
                            .font(.footnote)
                    }
                    if maximum > Metrics.distance.min {
                        Text(NSNumber(value: maximum), formatter: session.decimal)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        if metres > maximum {
                            Group {
                                Text(NSNumber(value: metres / maximum), formatter: session.decimal) +
                                Text(verbatim: "x")
                            }
                            .font(Font.title3.bold())
                            .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .frame(width: 250, height: 250)
            Spacer()
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
