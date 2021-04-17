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
                Chart.Footer(top: session.measures.string(from: Measurement(value: .init(max), unit: UnitLength.meters)))
            }
            Spacer()
        }
        
        private var count: Int {
            min(Constants.chart.max, metres.values.count)
        }
    }
}
