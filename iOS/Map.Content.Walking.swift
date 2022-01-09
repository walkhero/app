import SwiftUI
import Combine
import Hero

extension Map.Content {
    struct Walking: View {
        weak var status: Status!
        @ObservedObject var health: Health
        weak var animate: PassthroughSubject<UISheetPresentationController.Detent.Identifier, Never>!
        let started: Date
        @State private var currentTiles = Set<Tile>([])
        @State private var newTiles = Set<Tile>([])
        
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
                            let steps = health.steps
                            let distance = health.distance
                            let tiles = newTiles
                            
                            await cloud.finish(steps: steps,
                                               metres: distance,
                                               tiles: tiles)
                            health.clear()
                            location.end()
                            await UNUserNotificationCenter.send(message: "Walk finished!")
                            
                            let streak = await cloud.model.calendar.streak.current
                            let map = await cloud.model.tiles.count
                            
                            game.submit(streak: streak, steps: steps, distance: distance, map: map)
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
                        .font(.callout.monospacedDigit().weight(.light))
                }
                HStack {
                    Text("Distance")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                    Text(.init(value: .init(health.distance),
                                     unit: UnitLength.meters),
                         format: .measurement(width: .wide,
                                              usage: .road,
                                              numberFormatStyle: .number))
                        .font(.callout.monospacedDigit().weight(.light))
                }
                HStack {
                    Text("New squares")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                    Text(newTiles
                            .subtracting(currentTiles)
                            .count, format: .number)
                        .font(.callout.monospacedDigit().weight(.light))
                }
            }
            .onReceive(location.tiles) {
                newTiles = $0
            }
            .onReceive(cloud) {
                currentTiles = $0.tiles
            }
        }
    }
}
