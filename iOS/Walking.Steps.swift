import SwiftUI
import Combine

extension Walking {
    struct Steps: View {
        @Binding var session: Session
        @Binding var steps: Int
        @State private var max = 0
        
        var body: some View {
            Text("STEPS")
                .font(.headline)
            Spacer()
            ZStack {
                Ring(percent: 1)
                    .stroke(Color.blue.opacity(0.2), lineWidth: 25)
                Ring(percent: max == 0 ? 0 : .init(steps % max) / .init(max))
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
                    if max > 0 {
                        Text(NSNumber(value: max), formatter: session.decimal)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        if steps > max {
                            Group {
                                Text(NSNumber(value: steps / max), formatter: session.decimal) +
                                Text(verbatim: "x")
                            }
                            .font(Font.title.bold())
                            .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .frame(maxWidth: 200, maxHeight: 200)
            Spacer()
                .onAppear {
                    max = session.archive.maxSteps
                }
        }
    }
}
