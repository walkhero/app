import SwiftUI

extension Home {
    struct Greet: View {
        @Binding var session: Session
        
        var body: some View {
            Button {
                withAnimation(.spring(blendDuration: 0.4)) {
                    session.section = .listed
                }
            } label: {
                VStack {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                    gradient: .init(colors: [.pink, .init(.systemIndigo)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottom))
                            .frame(width: 100, height: 100)
                        if session.player.image == nil {
                            Image(systemName: "person.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        } else {
                            Image(uiImage: session.player.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                                .clipShape(Circle())
                        }
                    }
                    Text(verbatim: session.player.name)
                        .font(Font.title3)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .id(session.player.name)
                    Label(session.archive.last == nil
                            ? "New player"
                            : session.relative.string(from: session.archive.last!.end, to: .init()), systemImage: "figure.walk")
                        .foregroundColor(.secondary)
                        .font(.callout)
                        .padding(.horizontal)
                }
            }
        }
    }
}
