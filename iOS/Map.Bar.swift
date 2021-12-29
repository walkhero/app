import SwiftUI

extension Map {
    struct Bar: View {
        weak var representable: Representable!
        @State var follow: Bool
        
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                    .ignoresSafeArea(edges: .horizontal)
                HStack {
                    Spacer()
    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.2.stack.3d.bottom.filled")
                            .font(.title2)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 60)
                    .padding(.trailing)
                    
                    Button {
                        follow.toggle()
                        representable.setUserTrackingMode(follow ? .follow : .none, animated: true)
                    } label: {
                        Image(systemName: follow ? "location.viewfinder" : "location")
                            .font(follow ? .title2 : .callout)
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
