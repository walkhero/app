import SwiftUI
import Hero

extension Detail {
    struct Distance: View {
        @Binding var session: Session
        let metres: Hero.Chart
        let max: Int
        
        var body: some View {
            Spacer()
            Chart.Title(max: session.measures.string(from: Measurement(value: .init(metres.max), unit: UnitLength.meters)),
                        average: session.measures.string(from: Measurement(value: .init(metres.average), unit: UnitLength.meters)),
                        count: metres.values.count)
            Chart(values: metres.values, color: .orange)
            if max > 0 {
                HStack {
                    Text("All time max ")
                    + Text(Measurement(value: .init(max), unit: UnitLength.meters), formatter: session.measures)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            }
            Spacer()
        }
        
        private var count: Int {
            min(Constants.chart.max, metres.values.count)
        }
    }
}
