import SwiftUI

extension Results {
    struct Item: View {
        let value: AttributedString
        
        var body: some View {
            Text(value
                .numeric(font: .title3.monospacedDigit().weight(.bold),
                         color: .primary))
                .font(.body.weight(.medium))
                .foregroundStyle(.secondary)
                .padding(.top, 14)
                .padding(.bottom, 3)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            
            Rectangle()
                .foregroundStyle(.quaternary)
                .frame(height: 1)
        }
    }
}
