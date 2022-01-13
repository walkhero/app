import SwiftUI

extension Stats {
    struct Item: View {
        let text: Text
        let title: String
        
        var body: some View {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                    .font(.callout)
                Spacer()
                text
                    .font(.body.weight(.light).monospacedDigit())
            }
        }
    }
}
