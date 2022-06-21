import SwiftUI

struct Main: View {
    let session: Session
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Actions(session: session)
            Stats(session: session)
        }
    }
}
