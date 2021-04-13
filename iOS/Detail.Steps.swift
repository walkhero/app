import SwiftUI
import Hero

extension Detail {
    struct Steps: View {
        @Binding var session: Session
        let steps: Hero.Chart
        let max: Int
        
        var body: some View {
            Spacer()
            Chart.Title(max: session.decimal.string(from: NSNumber(value: steps.max))! + " steps",
                        average: session.decimal.string(from: NSNumber(value: steps.average))! + " steps",
                        count: steps.values.count)
            Chart(values: steps.values, color: .pink)
            if max > 0 {
                HStack {
                    Text("All Time Max ") +
                    Text(NSNumber(value: max), formatter: session.decimal) +
                    Text(" steps")
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            }
        }
    }
}
