import SwiftUI

extension Walking {
    struct Actions: View {
        let walker: Walker
        @State private var alert = false
        
        var body: some View {
            VStack(spacing: 0) {
                if alert {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 35, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.yellow)
                    
                    Button("Cancel walk", role: .destructive) {
                        Task {
                            await walker.cancel()
                        }
                    }
                    .font(.callout)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    
                    Button("Keep walking", role: .cancel) {
                        alert = false
                    }
                    .font(.callout.weight(.regular))
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                } else {
                    HStack {
                        Button("Cancel", role: .destructive) {
                            alert = true
                        }
                        .font(.callout.weight(.regular))
                        .foregroundStyle(.secondary)
                        .buttonStyle(.plain)
                        .padding(.leading, 22)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Button("Finish") {
                        Task {
                            
                        }
                    }
                    .font(.body.weight(.semibold))
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
            .animation(.easeInOut(duration: 0.4), value: alert)
        }
    }
}
