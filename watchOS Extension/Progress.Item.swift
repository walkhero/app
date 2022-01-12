import SwiftUI

extension Progress {
    struct Item: View {
        let text: Text
        let caption: Text
        let title: String
        let subtitle: String
        
        var body: some View {
            Text(title)
                .foregroundColor(.secondary)
                .font(.title3.weight(.light))
                .padding([.top, .trailing])
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.accentColor.opacity(0.4))
                text
                    .font(.title2.monospacedDigit())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding()
            }
            .padding(.horizontal)
        
            HStack {
                Spacer()
                Text(subtitle)
                    .foregroundColor(.secondary)
                    .font(.body)
                + caption
                    .foregroundColor(.secondary)
                    .font(.body.monospacedDigit())
            }
            .padding([.bottom, .trailing])
        }
    }
}
