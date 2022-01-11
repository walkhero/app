import SwiftUI

struct Walking: View {
    @ObservedObject var status: Status
    let started: Date
    @State private var alert = false
    
    var body: some View {
        HStack {
            Button {
                alert = true
            } label: {
                Text("Cancel")
                    .padding(.leading)
            }
            .buttonStyle(.plain)
            .foregroundColor(.pink)
            .font(.callout)
            .alert("Cancel walk?", isPresented: $alert) {
                Button("Continue", role: .cancel) {
                    
                }
                
                Button("Cancel", role: .destructive) {
                    Task {
                        await status.cancel()
                    }
                }
            }
            
            Spacer()
            
            Button {
                Task {
                    await status.finish()
                }
            } label: {
                Text("Finish")
                    .font(.body.weight(.medium))
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(.indigo)
            .foregroundColor(.white)
            .font(.callout)
        }
        .padding()
        
        TimelineView(.periodic(from: started, by: 0.25)) { time in
            Canvas { context, size in
                let duration = time.date.timeIntervalSince(started)
                let center = CGPoint(x: size.width / 2, y: 92)
                
                context.draw(clock: .init(round(duration.truncatingRemainder(dividingBy: 60) * 2)),
                             center: center,
                             side: 90)
                
                context.draw(Text((started ..< .now).formatted(.timeDuration))
                                .font(duration < 60 ? .largeTitle.monospaced() : .title.monospaced())
                                .fontWeight(.ultraLight), at: center)
            }
        }
        .frame(height: 184)
        
        Spacer()
        
        Stats(status: status)
        
        Spacer()
    }
}
