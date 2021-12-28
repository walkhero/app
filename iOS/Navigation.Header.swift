import SwiftUI

private let size = 40.0
private let radius = 10.0

extension Navigation {
    struct Header: View {
        @ObservedObject var status: Status
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .fill(LinearGradient(
                                gradient: .init(colors: [.accentColor.opacity(0.6), .accentColor]),
                                    startPoint: .top,
                                    endPoint: .bottom))
                            .frame(width: size, height: size)

                        if let image = status.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size - 3, height: size - 3)
                                .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
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
                    
                    Button(action: game.leaderboard) {
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
