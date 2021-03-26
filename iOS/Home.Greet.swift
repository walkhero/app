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
                                    gradient: .init(colors: [.init(.systemIndigo), .pink]),
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
                                .frame(width: 94, height: 94)
                                .clipShape(Circle())
                        }
                    }
                    Text(verbatim: session.player.name)
                        .font(Font.title2.bold())
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .id(session.player.name)
                    Label(session.archive.last == nil
                            ? "New Hero"
                            : session.relative.string(from: session.archive.last!.end, to: .init()), systemImage: "figure.walk")
                        .foregroundColor(.primary)
                        .font(.footnote)
                        .padding(.horizontal)
                }
            }
        }
    }
}
