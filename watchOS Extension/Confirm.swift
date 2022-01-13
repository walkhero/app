import SwiftUI

struct Confirm: View {
    let finish: Finish
    let done: () -> Void
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Walk\ncompleted!")
                Image(systemName: "checkmark.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .font(.largeTitle.weight(.light))
                    .foregroundColor(.accentColor)
            }
            .padding(.vertical)
            
            Item(text: .init(finish.streak, format: .number), title: "Streak")
                .padding(.top)
            Item(text: .init((finish.started ..< .now).formatted(.timeDuration)), title: "Duration")
            Item(text: .init(finish.steps, format: .number), title: "Steps")
            Item(text: .init(.init(value: .init(finish.meters),
                             unit: UnitLength.meters),
                       format: .measurement(width: .abbreviated,
                                            usage: .general,
                                            numberFormatStyle: .number)), title: "Distance")
            Item(text: .init(finish.squares, format: .number), title: "Squares")
                .padding(.bottom)
            
            Button(action: done) {
                ZStack {
                    Capsule()
                        .fill(Color.white)
                    Text("Done")
                        .font(.callout.weight(.medium))
                        .padding(.horizontal, 20)
                        .padding()
                }
                .fixedSize()
            }
            .buttonStyle(.plain)
            .foregroundColor(.black)
            .padding(.vertical)
        }
    }
}
