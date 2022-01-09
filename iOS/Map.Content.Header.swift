import SwiftUI
import Combine

private var width = 50.0

extension Map.Content {
    struct Header: View {
        let walking: Bool
        weak var health: Health!
        weak var animate: PassthroughSubject<UISheetPresentationController.Detent.Identifier, Never>!
        @State private var stats = false
        @State private var calendar = false
        @State private var alert = false
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    if walking {
                        Image(systemName: "figure.walk")
                            .foregroundColor(.accentColor)
                        Button {
                            alert = true
                        } label: {
                            Text("Cancel")
                                .font(.footnote)
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
                                    await UNUserNotificationCenter.send(message: "Walk cancelled!")
                                }
                                animate.send(.medium)
                            }
                        }
                        
                    } else {
                        Button {
                            Task {
                                await cloud.start()
                                await UNUserNotificationCenter.send(message: "Walk started!")
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
                .padding([.leading, .trailing, .top])
                .padding(.bottom, 10)
                Rectangle()
                    .fill(Color.primary.opacity(0.05))
                    .frame(height: 1)
                    .padding(.horizontal)
                    .allowsHitTesting(false)
            }
            .background(Color(.secondarySystemBackground))
        }
    }
}
