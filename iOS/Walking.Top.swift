import SwiftUI

extension Walking {
    struct Top: View {
        let session: Session
        let walker: Walker
        @State private var alert = false
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            VStack(spacing: 0) {
                ZStack {
                    TimelineView(.animation(minimumInterval: 1, paused: phase != .active)) { time in
                        VStack(spacing: 0) {
                            Text(.duration(start: session.walking, current: time.date))
                                .font(.system(size: 24, weight: .regular).monospacedDigit())
                                .frame(height: 60)
                            Progress(current: .init(time.date.timestamp - session.walking),
                                     max: session.chart.duration.max)
                                .stroke(Color.accentColor, style: .init(lineWidth: 4, lineCap: .round))
                                .frame(height: 4)
                        }
                    }
                    
                    HStack {
                        Button("Cancel", role: .cancel) {
                            alert = true
                        }
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.secondary)
                        .buttonStyle(.plain)
                        .alert("Cancel walk?", isPresented: $alert) {
                            Button("Cancel", role: .destructive) {
                                Task {
                                    await walker.cancel()
                                    await UNUserNotificationCenter.send(message: "Walk cancelled!")
                                }
                            }
                            
                            Button("Keep walking", role: .cancel) { }
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Finish")
                                .font(.system(size: 15, weight: .semibold))
                                .padding(.horizontal, 2)
                        }
                        .buttonBorderShape(.capsule)
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)
                    .frame(height: 60)
                }
                .fixedSize(horizontal: false, vertical: true)
                Divider()
            }
            .background(Color(.systemBackground))
        }
    }
}
