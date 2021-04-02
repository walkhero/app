import SwiftUI
import Hero

extension Detail {
    struct Steps: View {
        @Binding var session: Session
        let steps: Hero.Chart
        let max: Int
        
        var body: some View {
            Spacer()
            if max > 0 {
                HStack {
                    Text("Max ") +
                    Text(NSNumber(value: steps.max), formatter: session.decimal)
                    Spacer()
                }
                .font(Font.title.bold())
                .padding(.horizontal)
                Text("Over the last " + (count == 1 ? "Walk" : "\(count) Walks"))
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.leading)
            }
            Chart(values: steps.values, color: .pink)
                .frame(height: 260)
                .padding(.horizontal)
                .padding(.vertical, 5)
            if max > 0 {
                HStack {
                    Text("All Time Max ")
                    + Text(NSNumber(value: max), formatter: session.decimal)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            }
        }
        
        private var count: Int {
            min(Metrics.chart.vertical, steps.values.count)
        }
    }
}
