import SwiftUI
import Hero

extension Detail {
    struct Distance: View {
        @Binding var session: Session
        let metres: Hero.Chart
        let max: Int
        
        var body: some View {
            Spacer()
            if max > 0 {
                HStack {
                    Text("Max")
                    Text(Measurement(value: .init(metres.max), unit: UnitLength.meters), formatter: session.measures)
                    Spacer()
                }
                .font(Font.body.bold())
                .padding(.horizontal)
                Text("Over the last " + (count == 1 ? "Walk" : "\(count) Walks"))
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.leading)
            }
            Chart(values: metres.values, color: .purple)
                .frame(height: 260)
                .padding(.horizontal)
                .padding(.vertical, 5)
            if max > 0 {
                HStack {
                    Text("All Time Max")
                    Text(Measurement(value: .init(max), unit: UnitLength.meters), formatter: session.measures)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            }
        }
        
        private var count: Int {
            min(Metrics.chart.vertical, metres.values.count)
        }
    }
}
