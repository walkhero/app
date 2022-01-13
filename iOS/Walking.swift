import SwiftUI

struct Walking: View {
    weak var status: Status!
    let started: Date
    @State private var alert = false
    
    var body: some View {
        HStack {
            Button {
                alert = true
            } label: {
                Text("Cancel")
                    .font(.callout)
                    .padding(.leading)
            }
            .buttonStyle(.plain)
            .foregroundColor(.pink)
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
                    .font(.callout.weight(.medium))
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(.indigo)
            .foregroundColor(.white)
        }
        .padding()
        
        TimelineView(.periodic(from: started, by: 0.25)) { time in
            Canvas { context, size in
                let duration = time.date.timeIntervalSince(started)
                let center = CGPoint(x: size.width / 2, y: 92)
                
                context.draw(clock: .init(round(duration.truncatingRemainder(dividingBy: 60) * 2)),
                             center: center,
                             side: 80,
                             color: .secondary)
                
                context.draw(Text(started ..< .now, format: .timeDuration)
                                .font(duration < 60 ? .largeTitle.monospacedDigit() : .title.monospacedDigit())
                                .fontWeight(.light), at: center)
            }
        }
        .frame(height: 184)
        
        Spacer()
        
        Stats(status: status)
        
        Spacer()
    }
}
