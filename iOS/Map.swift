import SwiftUI

struct Map: View {
    weak var representable: Representable!
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                representable
                    .edgesIgnoringSafeArea(.all)
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                Header {
                    dismiss()
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Bar(representable: representable, follow: representable.userTrackingMode == .follow)
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}
