import SwiftUI

private let size = 36.0

extension Navigation {
    struct Header: View {
        @ObservedObject var status: Status
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                gradient: .init(colors: [.accentColor.opacity(0.6), .accentColor]),
                                    startPoint: .top,
                                    endPoint: .bottom))
                            .frame(width: size, height: size)

                        if let image = status.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size - 2, height: size - 2)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.fill")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                    .allowsHitTesting(false)
                    
                    Text(verbatim: status.name)
                        .foregroundColor(.primary)
                        .font(.callout)
                        .allowsHitTesting(false)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "list.star")
                            .font(.body)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 45)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.callout)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 45)
                }
                .padding([.leading, .trailing, .top])
                .padding(.bottom, 7)
                Divider()
                    .ignoresSafeArea(edges: .horizontal)
            }
            .background(.thinMaterial)
        }
    }
}
