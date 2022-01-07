import SwiftUI

private let radius = 20.0

extension Navigation {
    struct Geo: View {
        @State private var show = false
        @State private var tiles = 0
        private let map = Map.Representable()
        
        var body: some View {
            Button {
                show = true
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    if !show {
                        map
                    }
                    LinearGradient(
                        gradient: .init(colors: [.init(white: 0, opacity: 0),
                                                 .init(white: 0, opacity: 0),
                                                 .init(white: 0, opacity: 0.7)]),
                        startPoint: .top,
                        endPoint: .bottom)
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(.tertiaryLabel), lineWidth: 1)
                    Group {
                        Text(tiles, format: .number)
                            .foregroundColor(.white)
                            .font(.callout.monospacedDigit())
                        + Text(tiles == 1 ? " square" : " squares")
                            .foregroundColor(.init(white: 0.6))
                            .font(.footnote)
                    }
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                .allowsHitTesting(false)
            }
            .frame(height: 260)
            .padding()
            .onReceive(cloud) {
                tiles = $0.tiles.count
            }
            .sheet(isPresented: $show) {
                Map(representable: map)
            }
        }
    }
}
