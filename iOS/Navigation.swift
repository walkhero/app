import SwiftUI

struct Navigation: View {
    @Binding var status: Status
    
    var body: some View {
        VStack {
            Circle()
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Divider()
                    .ignoresSafeArea(edges: .horizontal)
                HStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        Image(systemName: "figure.walk.circle.fill")
                            .font(.largeTitle)
                            .allowsHitTesting(false)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 2)
            }
            .background(.thinMaterial)
        }
    }
}
