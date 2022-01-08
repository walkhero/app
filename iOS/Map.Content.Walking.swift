import SwiftUI

extension Map.Content {
    struct Walking: View {
        weak var status: Status!
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
                .frame(height: 200)
                
//                if let walking = walking {
//                    Section {
//
//                    }
//                } else {
//                    Section {
//                        Text("Start a walk")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
//                    } header: {
//                        HStack {
//                            Spacer()
//                            Button {
//
//                            } label: {
//                                Image(systemName: "figure.walk.circle.fill")
//                                    .symbolRenderingMode(.hierarchical)
//                                    .font(.largeTitle)
//                            }
//                            .padding(.top)
//                            Spacer()
//                        }
//                    }
//                    .listRowBackground(Color.clear)
//                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
    }
}
