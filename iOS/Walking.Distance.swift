import SwiftUI
import Combine

extension Walking {
    struct Distance: View {
        @Binding var session: Session
        @Binding var metres: Int
        @State private var maximum = 1
        
        var body: some View {
            Text("DISTANCE")
                .font(.headline)
            Spacer()
            ZStack {
                Ring(percent: 1)
                    .stroke(Color.blue.opacity(0.2), lineWidth: 25)
                Ring(percent: .init(metres % maximum) / .init(maximum))
                    .stroke(LinearGradient(
                                gradient: .init(colors: [.init(.systemIndigo), .blue]),
                                startPoint: .top,
                                endPoint: .bottom),
                            style: .init(lineWidth: 25,
                                         lineCap: .round))
                VStack {
                    Text(Measurement(value: .init(metres), unit: UnitLength.meters), formatter: session.measures)
                        .font(Font.title3.bold())
                        .padding(.horizontal)
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
                .onAppear {
                    maximum = max(session.archive.maxMetres, Metrics.distance.min)
                }
        }
    }
}
