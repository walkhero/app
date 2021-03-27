import SwiftUI
import Combine

extension Walking {
    struct Steps: View {
        @Binding var session: Session
        @Binding var steps: Int
        @State private var maximum = 1
        
        var body: some View {
            Text("STEPS")
                .font(.headline)
            Spacer()
            ZStack {
                Ring(percent: 1)
                    .stroke(Color.blue.opacity(0.2), lineWidth: 25)
                Ring(percent: .init(steps % maximum) / .init(maximum))
                    .stroke(LinearGradient(
                                gradient: .init(colors: [.init(.systemIndigo), .blue]),
                                startPoint: .top,
                                endPoint: .bottom),
                            style: .init(lineWidth: 25,
                                         lineCap: .round))
                VStack {
                    Text(NSNumber(value: steps), formatter: session.decimal)
                        .font(Font.largeTitle.bold())
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
                            .font(Font.title.bold())
                            .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .frame(width: 250, height: 250)
            Spacer()
                .onAppear {
                    maximum = max(session.archive.maxSteps, Metrics.steps.min)
                }
        }
    }
}
