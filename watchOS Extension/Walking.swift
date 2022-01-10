import SwiftUI
import UserNotifications
import Hero

struct Walking: View {
    @ObservedObject var health: Health
    let started: Date
    @State private var currentTiles = Set<Tile>([])
    @State private var newTiles = Set<Tile>([])
    @State private var alert = false
    
    var body: some View {
        List {
            Section {
                TimelineView(.periodic(from: started, by: 0.25)) { time in
                    Canvas { context, size in
                        let duration = time.date.timeIntervalSince(started)
                        let center = CGPoint(x: size.width / 2, y: (size.height / 2) + 10)
                        
                        context.draw(clock: .init(round(duration.truncatingRemainder(dividingBy: 60) * 2)),
                                     center: center,
                                     side: min(size.width, size.height) * 0.35)
                        
                        context.draw(Text((started ..< .now).formatted(.timeDuration))
                                        .font(duration < 60 ? .title3.monospaced() : .footnote.monospaced())
                                        .fontWeight(.ultraLight), at: center)
                    }
                }
                .frame(height: 150)

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
                } label: {
                    Text("Finish")
                }
                .buttonStyle(.borderedProminent)
            }
            .listRowBackground(Color.clear)
            
            Section {
                Button {
                    alert = true
                } label: {
                    Text("Cancel")
                        .font(.footnote)
                        .frame(maxWidth: .greatestFiniteMagnitude)
                }
                .buttonStyle(.plain)
                .foregroundColor(.secondary)
                .alert("Cancel walk?", isPresented: $alert) {
                    Button("Continue", role: .cancel) {
                        
                    }
                    
                    Button("Cancel", role: .destructive) {
                        Task {
                            await cloud.cancel()
                            health.clear()
                            location.end()
                            await UNUserNotificationCenter.send(message: "Walk cancelled!")
                        }
                    }
                }
            }
            .listRowBackground(Color.clear)
            
            Section {
                HStack {
                    Text("Steps")
                        .foregroundColor(.secondary)
                        .font(.caption2)
                    Spacer()
                    Text(health.steps, format: .number)
                        .font(.caption.monospacedDigit().weight(.light))
                }
                HStack {
                    Text("Distance")
                        .foregroundColor(.secondary)
                        .font(.caption2)
                    Spacer()
                    Text(.init(value: .init(health.distance),
                                     unit: UnitLength.meters),
                         format: .measurement(width: .wide,
                                              usage: .road,
                                              numberFormatStyle: .number))
                        .font(.caption.monospacedDigit().weight(.light))
                }
                HStack {
                    Text("New squares")
                        .foregroundColor(.secondary)
                        .font(.caption2)
                    Spacer()
                    Text(newTiles
                            .subtracting(currentTiles)
                            .count, format: .number)
                        .font(.caption.monospacedDigit().weight(.light))
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .onReceive(location.tiles) {
            newTiles = $0
        }
        .onReceive(cloud) {
            currentTiles = $0.tiles
        }
    }
}
