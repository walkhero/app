import SwiftUI

struct Home: View {
    var body: some View {
        Button {
            Task {
                await cloud.start()
            }
        } label: {
            ZStack {
                Circle()
                    .fill(Color.accentColor.opacity(0.35))
                Circle()
                    .fill(Color.accentColor)
                    .padding(3)
                Text("Start")
                    .font(.body.weight(.medium))
                    .foregroundColor(.white)
                    .padding(32)
            }
            .fixedSize()
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
