import SwiftUI
import Combine

extension Map.Content {
    struct Walking: View {
        weak var status: Status!
        @ObservedObject var health: Health
        weak var animate: PassthroughSubject<UISheetPresentationController.Detent.Identifier, Never>!
        let started: Date
        
        var body: some View {
            Section {
                TimelineView(.periodic(from: started, by: 0.25)) { time in
                    Canvas { context, size in
                        let duration = time.date.timeIntervalSince(started)
                        let center = CGPoint(x: size.width / 2, y: 100)
                        
                        context.draw(clock: .init(round(duration.truncatingRemainder(dividingBy: 60) * 2)),
                                     center: center,
                                     side: 80)
                        status
                            .components
                            .string(from: duration)
                            .map {
                                context.draw(Text($0)
                                                .font(.title.monospaced().weight(.ultraLight)), at: center)
                            }
                    }
                }
                .frame(height: 180)
                
                HStack {
                    Spacer()
                    Button {
                        Task {
                            await cloud.finish(steps: 0, metres: 0, tiles: [])
                            health.clear()
                            await UNUserNotificationCenter.send(message: "Walk finished!")
                        }
                        animate.send(.medium)
                    } label: {
                        Text("Finish")
                            .frame(maxWidth: 120)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            
            Section {
                HStack {
                    Text("Steps")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                    Text(health.steps, format: .number)
                }
                HStack {
                    Text("Distance")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                    Text(health.distance, format: .number)
                }
                HStack {
                    Text("Squares")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                }
            }
        }
    }
}
