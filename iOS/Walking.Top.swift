import SwiftUI

extension Walking {
    struct Top: View {
        let session: Session
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            VStack(spacing: 0) {
                ZStack {
                    TimelineView(.animation(minimumInterval: 1, paused: phase != .active)) { time in
                        VStack(spacing: 0) {
                            Text(duration(date: time.date))
                                .font(.system(size: 24, weight: .regular).monospacedDigit())
                                .frame(height: 60)
                            Progress(current: .init(time.date.timestamp - session.walking),
                                     max: session.chart.duration.max)
                                .stroke(Color.accentColor, style: .init(lineWidth: 2, lineCap: .round))
                                .frame(height: 2)
                        }
                    }
                    
                    HStack {
                        Button("Cancel", role: .cancel) {
                            
                        }
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.secondary)
                        .buttonStyle(.plain)
                        
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
        
        private func duration(date: Date) -> AttributedString {
            var duration = AttributedString((.init(timestamp: session.walking) ..< date).formatted(.timeDuration))
            
            if Int(date.timeIntervalSince1970) % 2 == 1 {
                if let range = duration.range(of: ":") {
                    duration[range].foregroundColor = .clear
                }
                if let range = duration.range(of: ":", options: [.backwards]) {
                    duration[range].foregroundColor = .clear
                }
            }
            
            return duration
        }
    }
}
