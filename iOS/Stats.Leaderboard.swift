import SwiftUI

private let size = 60.0
private let radius = 16.0

extension Stats {
    struct Leaderboard: View {
        let streak: Int
        let steps: Int
        let distance: Int
        let map: Int
        @StateObject private var game = Game()
        @State private var published = false
        
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
                .allowsHitTesting(false)
                
                HStack {
                    Spacer()
                    Button {
                        game.leaderboard()
                    } label: {
                        Label("Leaderboards", systemImage: "list.star")
                            .font(.callout.weight(.medium))
                            .imageScale(.large)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.blue)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button {
                        published = true
                        game.submit(streak: streak,
                                    steps: steps,
                                    distance: distance,
                                    map: map)
                        
                        Task {
                            _ = await UNUserNotificationCenter.send(message: "Scores published!")
                        }
                    } label: {
                        Label("Publish scores", systemImage: "arrow.up")
                            .font(.callout.weight(.medium))
                            .imageScale(.large)
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)
                    .disabled(published)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
    }
}
