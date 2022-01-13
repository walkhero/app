import SwiftUI

struct Controls: View {
    weak var status: Status!
    @Binding var finish: Finish?
    let started: Date
    @State private var alert = false
    
    var body: some View {
        VStack {
            Button {
                alert = true
            } label: {
                Text("Cancel")
                    .font(.callout)
                    .padding(.leading)
            }
            .buttonStyle(.plain)
            .foregroundColor(.pink)
            .font(.callout)
            .padding(.bottom, 30)
            .alert("Cancel walk?", isPresented: $alert) {
                Button("Continue", role: .cancel) {
                    
                }
                
                Button("Cancel", role: .destructive) {
                    Task {
                        await status.cancel()
                    }
                }
            }
            
            Button {
                Task {
                    let steps = status.steps
                    let meters = status.distance
                    let squares = await status.tiles.subtracting(cloud.model.tiles).count
                    
                    await status.finish()
                    
                    finish = .init(started: started,
                                   steps: steps,
                                   meters: meters,
                                   squares: squares,
                                   streak: await cloud.model.calendar.streak.current)
                }
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.accentColor)
                    Text("Finish")
                        .font(.callout.weight(.medium))
                        .padding(.horizontal, 40)
                        .padding()
                }
                .fixedSize()
            }
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .padding(.vertical)
        }
    }
}
