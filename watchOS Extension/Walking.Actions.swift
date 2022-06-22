import SwiftUI

extension Walking {
    struct Actions: View {
        let walker: Walker
        @State private var alert = false
        
        var body: some View {
            ZStack {
                if alert {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 35, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.yellow)
                        
                        Spacer()
                        
                        Button("Keep walking", role: .cancel) {
                            alert = false
                        }
                        .font(.callout.weight(.regular))
                        .buttonStyle(.plain)
                        .foregroundStyle(.secondary)
                    }
                    
                    Button("Cancel walk", role: .destructive) {
                        Task {
                            await walker.cancel()
                        }
                    }
                    .font(.callout)
                    .padding(.horizontal)
                } else {
                    VStack {
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
                        
                        Image(systemName: "figure.walk")
                            .font(.system(size: 25, weight: .light))
                            .foregroundStyle(.tertiary)
                    }
                    
                    Button("Finish") {
                        Task {
                            
                        }
                    }
                    .font(.body.weight(.semibold))
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 16)
                }
            }
            .animation(.easeInOut(duration: 0.4), value: alert)
        }
    }
}
