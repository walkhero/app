import SwiftUI
import Combine

private let size = 32.0
private let radius = 8.0

extension Map.Content {
    struct Game: View {
        @ObservedObject var status: Status
        weak var leaderboards: PassthroughSubject<Void, Never>!
        
        var body: some View {
            Section("Game Center") {
                HStack {
                    if let image = status.image {
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
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)
                    }
                    Text(verbatim: status.name)
                        .lineLimit(2)
                        .foregroundColor(.primary)
                        .font(.body)
                        .allowsHitTesting(false)
                }
                .allowsHitTesting(false)
                
                Button {
                    leaderboards.send()
                } label: {
                    Label("Leaderboards", systemImage: "list.star")
                        .font(.callout.weight(.medium))
                        .frame(maxWidth: .greatestFiniteMagnitude)
                        .imageScale(.large)
                        .allowsHitTesting(false)
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
                .foregroundColor(.white)
            }
            .headerProminence(.increased)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
    }
}
