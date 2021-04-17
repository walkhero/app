import SwiftUI
import Hero

extension Chart {
    struct Footer: View {
        let top: String
        
        var body: some View {
            Text("All time max " + top)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
        }
    }
}
