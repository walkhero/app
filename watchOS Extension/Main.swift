import SwiftUI

struct Main: View {
    let session: Session
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            VStack {
                Spacer()
                
                Text("Walk")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.tertiary)
                
                Button {
                    Task {
                        await cloud.start()
                    }
                } label: {
                    Image(systemName: "figure.walk")
                        .font(.system(size: 22, weight: .medium))
                        .contentShape(Rectangle())
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 30)
                
                Spacer()
            }
            
            Stats(session: session)
        }
    }
}
