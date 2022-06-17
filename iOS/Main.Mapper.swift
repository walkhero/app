import SwiftUI

extension Main {
    struct Mapper: View {
        @StateObject private var map = Map()
        
        var body: some View {
            map
                .safeAreaInset(edge: .top, spacing: 0) {
                    HStack {
                        Button {
                            map.setUserTrackingMode(.follow, animated: true)
                            map.setCameraZoomRange(.init(maxCenterCoordinateDistance: 1000), animated: true)
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .font(.system(size: 30, weight: .ultraLight))
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.accentColor)
                                .frame(width: 65, height: 65)
                                .contentShape(Rectangle())
                        }
                        
                        Spacer()
                    }
                }
//                .onChange(of: walker.overlay) {
//                    map.update(overlay: $0)
//                }
//                .onAppear {
//                    map.update(overlay: walker.overlay)
//                }
        }
    }

}
