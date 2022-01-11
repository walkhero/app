import SwiftUI

struct Placeholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
            Image(systemName: "figure.walk")
                .font(.largeTitle.weight(.ultraLight))
                .foregroundColor(.init(.tertiaryLabel))
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 260)
        .allowsHitTesting(false)
    }
}
