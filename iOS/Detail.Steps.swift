import SwiftUI
import Hero

extension Detail {
    struct Steps: View {
        @Binding var session: Session
        let steps: Hero.Steps
        let max: Int
        
        var body: some View {
            Spacer()
            if session.health.available {
                HStack {
                    Text("Max")
                    Text(NSNumber(value: steps.max), formatter: session.decimal)
                    Spacer()
                }
                .font(Font.body.bold())
                .padding(.horizontal)
                Text("Over the last \(Metrics.chart.vertical) Walks")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.leading)
                Chart(values: steps.values)
                    .frame(height: 260)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                HStack {
                    Text("All Time Max")
                    Text(NSNumber(value: max), formatter: session.decimal)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            } else {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.pink)
                    .padding(.bottom, 5)
                Text("Apple Health not available")
                Text("Apple Health app is necessary\nto get your step count.")
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
    }
}
