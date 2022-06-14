import SwiftUI

struct Window: View {
    @ObservedObject var session: Sesssion
    
    var body: some View {
        if session.loading {
            Image("Logo")
                .foregroundColor(.init(.tertiaryLabel))
                .frame(maxHeight: .greatestFiniteMagnitude)
                .edgesIgnoringSafeArea(.all)
        } else if session.walking > 0 {
            Walking(session: session)
        } else {
            
        }
    }
}
