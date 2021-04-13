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
                        .font(Font.title2.bold())
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
