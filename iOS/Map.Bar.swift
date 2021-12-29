import SwiftUI

extension Map {
    struct Bar: View {
        weak var representable: Representable!
        @State var follow: Bool
        @State private var layers = false
        
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                    .ignoresSafeArea(edges: .horizontal)
                HStack {
                    Spacer()
    
                    Button {
                        layers = true
                    } label: {
                        Image(systemName: "square.2.stack.3d.bottom.filled")
                            .font(.title3)
                            .allowsHitTesting(false)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 60)
                    .padding(.trailing)
                    .sheet(isPresented: $layers) {
                        Layers(rootView: .init())
                    }
                    
                    Button {
                        follow.toggle()
                        representable.setUserTrackingMode(follow ? .follow : .none, animated: true)
                    } label: {
                        Image(systemName: follow ? "location.viewfinder" : "location")
                            .font(follow ? .title2 : .callout)
                            .symbolRenderingMode(.hierarchical)
                            .allowsHitTesting(false)
                            .foregroundColor(follow ? .blue : .secondary)
                    }
                    .frame(width: 60)
                }
                .padding()
            }
            .background(.ultraThinMaterial)
        }
    }
}
