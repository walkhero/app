import SwiftUI

struct Control: View {
    let title: String
    let gradient: LinearGradient
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Capsule()
                    .fill(gradient)
                    .modifier(Shadowed())
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.callout)
                    .fontWeight(.medium)
                    .padding(.horizontal, 64)
                    .padding(.vertical, 10)
            }
            .fixedSize()
        }
    }
}
