import SwiftUI

struct Home: View {
    @Binding var session: Session
    @State private var name = "hello"
    
    var body: some View {
        VStack {
            Label(session.archive.last == nil
                    ? "New Hero"
                    : session.relative.string(from: session.archive.last!.end, to: .init()),
                  systemImage: "figure.walk")
                .font(.footnote)
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    session.archive.start()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                                gradient: .init(colors: [.blue, .purple]),
                                startPoint: .top,
                                endPoint: .bottom))
                    Image(systemName: "figure.walk")
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                        .padding(15)
                    Image(systemName: "plus")
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomTrailing)
                        .padding(15)
                }
                .foregroundColor(.black)
                .font(.title3)
                .frame(width: 70, height: 70)
            }
            .contentShape(Rectangle())
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom)
        }
    }
}
