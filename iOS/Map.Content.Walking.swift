import SwiftUI

extension Map.Content {
    struct Walking: View {
        weak var status: Status!
        let started: Date
        @State private var elapsed = ""
        private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        
        var body: some View {
            Section {
                Text(elapsed)
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
            .onAppear {
                refresh(.now)
            }
            .onReceive(timer, perform: refresh)
        }
        
        private func refresh(_ date: Date) {
            status
                .components
                .string(from: date.timeIntervalSince(started))
                .map {
                    elapsed = $0
                }
            
        }
    }
}
