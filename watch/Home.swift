import SwiftUI

struct Home: View {
    @Binding var session: Session
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "figure.walk")
                .font(.title)
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    session.archive.start()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                                gradient: .init(colors: [.blue, .purple]),
                                startPoint: .top,
                                endPoint: .bottom))
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .buttonStyle(PlainButtonStyle())
            .fixedSize()
            Spacer()
        }
    }
}
