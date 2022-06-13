import SwiftUI
import Hero

struct Main: View {
    weak var status: Status!
    @State private var started = UInt32()
    @State private var loading = true
    
    var body: some View {
        VStack {
            if loading {
                
            } else {
                
            }
            Text("hello")
            Spacer()
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(Color(.secondarySystemBackground))
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Divider()
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .contentShape(Rectangle())
                    }
                    .frame(width: 60, height: 60)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "star")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .contentShape(Rectangle())
                    }
                    .frame(width: 60, height: 60)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "figure.walk.circle.fill")
                            .font(.system(size: 40, weight: .bold))
                            .symbolRenderingMode(.hierarchical)
                            .contentShape(Rectangle())
                    }
                    .frame(width: 60, height: 60)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .contentShape(Rectangle())
                    }
                    .frame(width: 60, height: 60)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chart.pie")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .contentShape(Rectangle())
                    }
                    .frame(width: 60, height: 60)
                }
                .padding(.vertical, 10)
            }
        }
        .task {
            cloud.ready.notify(queue: .main) {
                loading = false
            }
        }
        .onReceive(cloud) { model in
            withAnimation(.easeInOut(duration: 0.3)) {
                started = model.walking
            }

            if model.walking > 0 {
                Task {
                    await status.start(date: .init(timestamp: model.walking))
                }
            } else if status.started {
                Task {
                    await status.cancel()
                }
            }
        }
        
//        ZStack(alignment: .bottom) {
//            Map(status: status)
//                .edgesIgnoringSafeArea(.top)
//                .padding(.bottom, started == nil ? 180 : 320)
//
//            Options(status: status)
//
//            Card(status: status, started: started)
//                .edgesIgnoringSafeArea(.bottom)
//                .frame(height: started == nil ? 260 : 430)
//                .offset(y: 40)
//        }
    }
}
