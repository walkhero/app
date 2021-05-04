import SwiftUI
import Hero

extension Detail {
    struct Steps: View {
        @Binding var session: Session
        let steps: Hero.Chart
        let max: Int
        
        var body: some View {
            Spacer()
            Chart.Title(max: session.decimal.string(from: .init(value: steps.max))! + " steps",
                        average: session.decimal.string(from: .init(value: steps.average))! + " steps",
                        count: steps.values.count)
            Chart(values: steps.values, color: .pink)
            if max > 0 {
                Chart.Footer(top: session.decimal.string(from: .init(value: max))! + " steps")
            }
            Spacer()
        }
    }
}
