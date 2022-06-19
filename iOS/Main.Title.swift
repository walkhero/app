import SwiftUI

extension Main {
    struct Title: View {
        let title: String
        
        var body: some View {
            VStack(spacing: 0) {
                Text(title)
                    .font(.title2.weight(.semibold))
                    .padding(.vertical, 12)
                    .padding(.leading, 20)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                Divider()
            }
            .background(Color(.systemBackground))
        }
    }
}
