import SwiftUI

private let size = 60.0
private let radius = 16.0

extension Stats {
    struct Leaderboard: View {
        @ObservedObject var game: Game
        
        var body: some View {
            Section {
                HStack {
                    Spacer()
                    if let image = game.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
                            .padding(.vertical, 10)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: radius, style: .continuous)
                                .fill(LinearGradient(
                                    gradient: .init(colors: [.accentColor.opacity(0.6), .accentColor]),
                                        startPoint: .top,
                                        endPoint: .bottom))
                                .frame(width: size, height: size)
                            Image(systemName: "person.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)
                    }
                    Text(verbatim: game.name)
                        .lineLimit(2)
                        .foregroundColor(.primary)
                        .font(.body)
                        .allowsHitTesting(false)
                    Spacer()
                }
                .padding(.top)
                .allowsHitTesting(false)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
    }
}
