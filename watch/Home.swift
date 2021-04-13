import SwiftUI

struct Home: View {
    @Binding var session: Session
    
    var body: some View {
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
            .font(.title2)
            .frame(width: 75, height: 75)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
