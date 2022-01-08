import SwiftUI
import Combine

private var width = 50.0

extension Map.Content {
    struct Header: View {
        let walking: Bool
        @State private var stats = false
        @State private var calendar = false
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    if walking {
                        Button {
                            Task {
                                await cloud.cancel()
                            }
                        } label: {
                            Text("Cancel walk")
                                .font(.footnote)
                        }
                        .buttonStyle(.plain)
                        .foregroundColor(.secondary)
                    } else {
                        Button {
                            Task {
                                await cloud.start()
                            }
                        } label: {
                            Text("Start a walk")
                                .font(.footnote)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    Spacer()
                    
                    Button {
                        stats = true
                    } label: {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.callout)
                            .allowsHitTesting(false)
                    }
                    .frame(width: width)
                    .sheet(isPresented: $stats, content: Stats.init)
                    
                    Button {
                        calendar = true
                    } label: {
                        Image(systemName: "calendar")
                            .font(.callout)
                            .allowsHitTesting(false)
                    }
                    .frame(width: width)
                    .sheet(isPresented: $calendar, content: Ephemeris.init)
                    
                    Button {
                        calendar = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.callout)
                            .allowsHitTesting(false)
                    }
                    .frame(width: width)
                    .sheet(isPresented: $calendar, content: Ephemeris.init)
                }
                .padding()
            }
            .background(Color(.secondarySystemBackground))
        }
    }
}
