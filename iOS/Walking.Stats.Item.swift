import SwiftUI

extension Walking.Stats {
    struct Item: View {
        let text: Text
        let title: String
        
        var body: some View {
            VStack {
                text
                    .font(.title2.monospacedDigit().weight(.light))
                Text(title)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            .frame(width: 100)
        }
    }
}
