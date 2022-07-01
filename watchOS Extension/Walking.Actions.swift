import SwiftUI
import Hero

extension Walking {
    struct Actions: View {
        @ObservedObject var session: Session
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
                    .padding(.horizontal, 10)
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
                            .foregroundColor(.accentColor)
                    }
                    
                    Button("Finish") {
                        Task {
                            session.summary = await walker.finish(walking: session.walking,
                                                                  chart: session.chart)
                        }
                    }
                    .font(.body.weight(.semibold))
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 20)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: alert)
        }
    }
}
