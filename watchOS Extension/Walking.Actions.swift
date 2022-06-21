import SwiftUI

extension Walking {
    struct Actions: View {
        let walker: Walker
        @State private var alert = false
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Button("Cancel", role: .destructive) {
                        alert = true
                    }
                    .font(.callout.weight(.regular))
                    .foregroundStyle(.secondary)
                    .buttonStyle(.plain)
                    .padding(.leading)
                    
                    Spacer()
                }
                
                Spacer()
                
                Button("Finish") {
                    Task {
                        
                    }
                }
                .font(.body.weight(.semibold))
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .alert("Cancel walk?", isPresented: $alert) {
                Button("Cancel", role: .destructive) {
                    Task {
                        await walker.cancel()
                    }
                }
                
                Button("Keep walking", role: .cancel) { }
            }
        }
    }
}
