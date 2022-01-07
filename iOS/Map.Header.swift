import SwiftUI

extension Map {
    struct Header: View {
        let close: () -> Void
        @State private var tiles = 0
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Group {
                        Text(tiles, format: .number)
                            .foregroundColor(.primary)
                            .font(.title3.monospacedDigit())
                        + Text(tiles == 1 ? " square" : " squares")
                            .foregroundColor(.secondary)
                            .font(.callout)
                    }
                    .padding()
                    Spacer()
                    Button(action: close) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .symbolRenderingMode(.hierarchical)
                            .font(.title2)
                            .frame(width: 50, height: 50)
                            .contentShape(Rectangle())
                    }
                }
                .padding(.horizontal, 5)
                Divider()
                    .ignoresSafeArea(edges: .horizontal)
            }
            .background(.thinMaterial)
            .onReceive(cloud) {
                tiles = $0.tiles.count
            }
        }
    }
}
