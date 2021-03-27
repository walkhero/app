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
                        if session.player.image == nil {
                            Circle()
                                .fill(LinearGradient(
                                        gradient: .init(colors: [.init(.systemIndigo), .pink]),
                                        startPoint: .topLeading,
                                        endPoint: .bottom))
                                .frame(width: 100, height: 100)
                            Image(systemName: "person.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        } else {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 100, height: 100)
                            Image(uiImage: session.player.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 96, height: 96)
                                .clipShape(Circle())
                        }
                    }
                    Text(verbatim: session.player.name)
                        .font(Font.title2.bold())
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .id(session.player.name)
                    Text(verbatim: session.archive.last == nil
                            ? "New Hero"
                            : session.relative.string(from: session.archive.last!.end, to: .init()))
                        .foregroundColor(.primary)
                        .font(.footnote)
                        .padding(.vertical, 1)
                        .padding(.horizontal)
                    Image(systemName: "figure.walk")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
