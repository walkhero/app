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
                    .fill(Color.accentColor)
                Text("Start")
                    .font(.body.weight(.medium))
                    .foregroundColor(.white)
                    .padding(30)
            }
            .fixedSize()
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
