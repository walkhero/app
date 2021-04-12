import SwiftUI

extension Home {
    struct Greet: View {
        @Binding var session: Session
        
        var body: some View {
            HStack {
                Button {
                    session.purchases.open.send()
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(width: 60, height: 60)
                }
                Spacer()
                Button {
                    withAnimation(.spring(blendDuration: 0.4)) {
                        session.section = .listed
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .fill(Color(.secondarySystemBackground))
                        Label(session.archive.last == nil
                                ? "New Hero"
                                : session.relative.string(from: session.archive.last!.start, to: .init()),
                              systemImage: "figure.walk")
                            .font(.footnote)
                            .foregroundColor(Color.primary)
                            .padding(.horizontal)
                    }
                    .frame(height: 35)
                    .fixedSize()
                }
                .padding(.trailing)
            }
            if session.player.image == nil {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                                gradient: .init(colors: [.init(.systemIndigo), .pink]),
                                startPoint: .topLeading,
                                endPoint: .bottom))
                        .frame(width: 100, height: 100)
                    Image(systemName: "person.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            } else {
                Image(uiImage: session.player.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            Text(verbatim: session.player.name)
                .font(Font.title2.bold())
                .foregroundColor(.accentColor)
                .padding(.horizontal)
                .id(session.player.name)
        }
    }
}
