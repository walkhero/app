import SwiftUI

extension Walking {
    struct Map: View {
        @Binding var session: Session
        
        var body: some View {
            WalkHero.Map(session: $session)
                .padding()
        }
    }
}
