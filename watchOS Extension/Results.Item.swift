import SwiftUI

extension Results {
    struct Item: View {
        let value: AttributedString
        
        var body: some View {
            Text(value
                .numeric(font: .title3.monospacedDigit().weight(.medium),
                         color: .primary))
                .font(.footnote.weight(.medium))
                .padding(.top, 3)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            
            Rectangle()
                .foregroundStyle(.quaternary)
                .frame(height: 1)
        }
    }
}
