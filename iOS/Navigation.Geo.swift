import SwiftUI

private let radius = 20.0

extension Navigation {
    struct Geo: View {
        var body: some View {
            Button {
                
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    Map()
                    LinearGradient(
                        gradient: .init(colors: [.init(white: 0, opacity: 0),
                                                 .init(white: 0, opacity: 0),
                                                 .init(white: 0, opacity: 0.9)]),
                        startPoint: .top,
                        endPoint: .bottom)
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(.tertiaryLabel), lineWidth: 1)
                    Group {
                        Text(3656532, format: .number)
                            .foregroundColor(.primary)
                            .font(.callout.monospaced())
                        + Text(" map squares")
                            .foregroundColor(.secondary)
                            .font(.callout)
                    }
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                .allowsHitTesting(false)
            }
            .frame(height: 200)
            .padding()
        }
    }
}
