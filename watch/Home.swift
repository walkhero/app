import SwiftUI
import GameKit

struct Home: View {
    @Binding var session: Session
    @State private var name = "hello"
    
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
                Text(name)
            }
            .foregroundColor(.black)
            .font(.title2)
            .frame(width: 80, height: 80)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            if !GKLocalPlayer.local.isAuthenticated {
                GKLocalPlayer.local.authenticateHandler = {
                    print("error")
                    print($0)
                    name = GKLocalPlayer.local.displayName
                    print("name \(name)")
                }
            }
            
        }
    }
}
