import SwiftUI
import Hero

struct Chart: View {
    @Binding var session: Session
    let steps: Hero.Chart
    let max: Int
    
    var body: some View {
        Spacer()
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
        Display(values: steps.values)
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
    }
}
