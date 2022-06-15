import SwiftUI
import Hero

struct Walking: View {
    @StateObject var session: Sesssion
    @State private var duration: AttributedString?
    @State private var tick = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(alignment: .firstTextBaseline) {
                    Text(session.chart.streak.current.formatted())
                        .font(.largeTitle.monospacedDigit().weight(.regular))
                    + Text(" Streak")
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(session.chart.walks.formatted() + " walks")
                        .font(.footnote.monospacedDigit().weight(.light))
                        .foregroundStyle(.secondary)
                }
                .modifier(Card())
                
                Item(value: .init(423432.formatted()), limit: .init(423432.formatted()), title: "Steps", percent: 0.6)
                Item(value: .init(13432.formatted()), limit: .init(13432.formatted()), title: "Metres", percent: 0.45)
                Item(value: .init(53432.formatted()), limit: .init(1332.formatted()), title: "Calories", percent: 0.75)
                Item(value: .init(53432.formatted()), limit: .init(1332.formatted()), title: "Squares", percent: 0.2)
            }
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .safeAreaInset(edge: .top, spacing: 0) {
            VStack(spacing: 0) {
                ZStack {
                    if let duration = duration {
                        Text(duration)
                            .font(.system(size: 24, weight: .regular).monospacedDigit())
                            .allowsHitTesting(false)
                            .accessibility(label: .init("Current walk duration"))
                    } else {
                        Image(systemName: "figure.walk")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 16, weight: .heavy))
                            .accessibility(label: .init("Loading current walk duration"))
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
                    .padding(.vertical, 12)
                }
                .fixedSize(horizontal: false, vertical: true)
                Progress(value: 0.8)
                    .stroke(Color.accentColor, style: .init(lineWidth: 2, lineCap: .round))
                    .frame(height: 2)
                Divider()
            }
            .background(Color(.systemBackground))
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Divider()
                
                Button {
                    
                } label: {
                    Image(systemName: "globe.europe.africa")
                        .font(.system(size: 30, weight: .light))
                        .frame(width: 60, height: 60)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.vertical, 5)
            }
            .background(Color(.systemBackground))
        }
        .onReceive(timer) { _ in
            tick.toggle()
            
            var duration = AttributedString((Date(timestamp: session.walking) ..< .now).formatted(.timeDuration))
            
            if tick {
                self.duration = duration
            } else {
                if let range = duration.range(of: ":") {
                    duration[range].foregroundColor = .clear
                }
                if let range = duration.range(of: ":", options: [.backwards]) {
                    duration[range].foregroundColor = .clear
                }
                
                self.duration = duration
            }
        }
    }
}

//import SwiftUI
//import Hero
//
//struct Walking: View {
//    @ObservedObject var status: Status
//    @Binding var summary: Summary?
//    let started: UInt32
//    @State private var duration = 0
//    @State private var steps = 0
//    @State private var metres = 0
//    @State private var alert = false
//    
//    var body: some View {
//        HStack {
//            Button {
//                alert = true
//            } label: {
//                Text("Cancel")
//                    .font(.callout)
//                    .padding(.leading)
//                    .contentShape(Rectangle())
//            }
//            .buttonStyle(.plain)
//            .foregroundColor(.pink)
//            .alert("Cancel walk?", isPresented: $alert) {
//                Button("Continue", role: .cancel) {
//                    
//                }
//                
//                Button("Cancel", role: .destructive) {
//                    Task {
//                        await status.cancel()
//                        await UNUserNotificationCenter.send(message: "Walk cancelled!")
//                    }
//                }
//            }
//            
//            Spacer()
//            
//            Button {
//                Task {
//                    summary = await status.finish()
//                    await UNUserNotificationCenter.send(message: "Walk finished!")
//                }
//            } label: {
//                Text("Finish")
//                    .font(.callout.weight(.medium))
//                    .padding(.horizontal)
//                    .contentShape(Rectangle())
//            }
//            .buttonStyle(.borderedProminent)
//            .buttonBorderShape(.capsule)
//            .foregroundColor(.white)
//        }
//        .padding([.top, .leading, .trailing])
//
//        TimelineView(.periodic(from: .init(timestamp: started), by: 0.5)) { time in
//            Canvas { context, size in
//                let center = CGPoint(x: size.width / 2, y: 130)
//                
//                if duration > 0 {
//                    context.ring(title: "duration",
//                                 center: center,
//                                 side: 90,
//                                 percent: (Date.now.timeIntervalSince1970 - .init(started)) / .init(duration),
//                                 anchor: .bottomTrailing)
//                    
//                    context.draw(Text(.init(timeIntervalSinceNow: .init(-duration)) ..< .now, format: .timeDuration)
//                                    .font(.footnote.monospacedDigit())
//                                    .fontWeight(.light)
//                                    .foregroundColor(.init(.tertiaryLabel)),
//                                 at: .init(x: center.x, y: center.y + 16))
//                }
//                
//                if steps > 0 {
//                    context.ring(title: "steps",
//                                 center: center,
//                                 side: 82,
//                                 percent: Double(status.steps) / .init(steps),
//                                 anchor: .trailing)
//                }
//                
//                if metres > 0 {
//                    context.ring(title: "distance",
//                                 center: center,
//                                 side: 74,
//                                 percent: Double(status.distance) / .init(metres),
//                                 anchor: .topTrailing)
//                }
//                
//                
//                if duration == 0 && steps == 0 && metres == 0 {
//                    context.ring(title: "First walk",
//                                 center: center,
//                                 side: 90,
//                                 percent: 1,
//                                 anchor: .trailing)
//                }
//                
//                context.draw(Text(.init(timestamp: started) ..< .now, format: .timeDuration)
//                                .font(.title2.monospacedDigit())
//                                .fontWeight(.light),
//                             at: .init(x: center.x, y: center.y - 3))
//            }
//        }
//        .frame(height: 240)
////        .onReceive(cloud) {
////            duration = $0.duration.max
////            steps = $0.steps.max
////            metres = $0.metres.max
////        }
//
//        Stats(status: status, steps: steps, metres: metres)
//        
//        Spacer()
//    }
//}
