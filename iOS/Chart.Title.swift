import SwiftUI
import Hero

extension Chart {
    struct Title: View {
        let max: String
        let average: String
        let count: Int
        
        var body: some View {
            if count > 0 {
                HStack {
                    Text("Max " + max)
                        .font(.title.bold())
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    Text("Average " + average)
                        .font(.callout)
                    Spacer()
                }
                .padding(.horizontal)
                Text("Over the last " + (min(Constants.chart.max, count) == 1 ? "walk" : "\(min(Constants.chart.max, count)) walks"))
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.leading)
            }
        }
    }
}
