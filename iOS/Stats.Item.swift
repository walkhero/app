import SwiftUI

extension Stats {
    struct Item: View {
        let text: Text
        let title: String
        
        var body: some View {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                    .font(.body)
                Spacer()
                text
                    .font(.title3.weight(.light).monospacedDigit())
            }
        }
    }
}
