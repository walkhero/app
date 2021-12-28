import SwiftUI

extension Navigation {
    struct Bar: View {
        @ObservedObject var status: Status
        
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                    .ignoresSafeArea(edges: .horizontal)
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "calendar")
                            .font(.title3)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 50)
                    
                    Spacer()
                    
                    Button {
                        print(status.name)
                    } label: {
                        Image(systemName: "figure.walk.circle.fill")
                            .font(.largeTitle)
                            .allowsHitTesting(false)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.title3)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 50)
                }
                .padding(.top, 10)
                .padding(.bottom, 2)
                .padding(.horizontal)
            }
            .background(.thinMaterial)
        }
    }

}
