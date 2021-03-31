import SwiftUI

extension Home {
    struct Greet: View {
        @Binding var session: Session
        
        var body: some View {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.secondary)
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
                            .fill(Color.primary)
                        Label(session.archive.last == nil
                                ? "New Hero"
                                : session.relative.string(from: session.archive.last!.end, to: .init()),
                              systemImage: "figure.walk")
                            .font(.footnote)
                            .foregroundColor(Color.primary)
                            .padding(.horizontal)
                            .colorInvert()
                    }
                    .frame(height: 35)
                    .fixedSize()
                }
                .padding(.trailing)
            }
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
                .foregroundColor(.accentColor)
                .padding(.horizontal)
                .id(session.player.name)
        }
    }
}
