import SwiftUI
import Hero

extension Walking {
    struct Top: View {
        @ObservedObject var session: Session
        @ObservedObject var walker: Walker
        let chart: Chart
        @State private var alert = false
        @Environment(\.scenePhase) private var phase
        
        var body: some View {
            VStack(spacing: 0) {
                ZStack {
                    TimelineView(.animation(minimumInterval: 1, paused: phase != .active)) { time in
                        VStack(spacing: 0) {
                            if session.walking > 0 {
                                Text(.duration(start: session.walking, current: time.date))
                                    .font(.system(size: 30, weight: .medium).monospacedDigit())
                                    .frame(height: 60)
                            }
                            
                            if chart.walks > 0 {
                                Text((.streak(value: chart.streak.current)
                                      + .init("  ")
                                      + .walks(value: chart.walks))
                                    .numeric(font: .callout.monospacedDigit(),
                                             color: .primary))
                                .font(.caption.weight(.regular))
                                .foregroundStyle(.secondary)
                                .padding(.bottom, 6)
                            }
                            
                            ZStack {
                                Capsule()
                                    .fill(Color.accentColor.opacity(0.2))
                                if session.walking > 0 && chart.duration.max > 0 {
                                    Progress(current: .init(time.date.timestamp - session.walking),
                                             max: chart.duration.max)
                                        .stroke(Color.accentColor, style: .init(lineWidth: 7, lineCap: .round))
                                }
                            }
                            .frame(height: 7)
                        }
                    }
                    
                    VStack {
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
                                    }
                                }
                                
                                Button("Keep walking", role: .cancel) { }
                            }
                            
                            Spacer()
                            
                            Button {
                                Task {
                                    session.summary = await walker.finish(
                                        walking: session.walking,
                                        chart: chart)
                                }
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
                        
                        Spacer()
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .background(Color(.systemBackground))
        }
    }
}
