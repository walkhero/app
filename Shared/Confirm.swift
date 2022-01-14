import SwiftUI

struct Confirm: View {
    let finish: Finish
    let done: () -> Void
    
    var body: some View {
        ScrollView {
            HStack(spacing: 12) {
                Image(systemName: "checkmark.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .font(.largeTitle.weight(.light))
                    .foregroundColor(.accentColor)
                Text("Walk\nfinished!")
                    .font(.footnote)
            }
            .padding(.top)
            .padding(.vertical, 10)
            
            Item(text: .init(finish.streak, format: .number), title: "Streak")
                .padding(.top, 10)
            Item(text: .init((finish.started ..< .now).formatted(.timeDuration)), title: "Duration")
            Item(text: .init(finish.steps, format: .number), title: "Steps")
            Item(text: .init(.init(value: .init(finish.meters),
                             unit: UnitLength.meters),
                       format: .measurement(width: .abbreviated,
                                            usage: .general,
                                            numberFormatStyle: .number)), title: "Distance")
            Item(text: .init(finish.squares, format: .number), title: "Squares")
                .padding(.bottom, 10)
            
            Button(action: done) {
                ZStack {
                    Capsule()
                        .fill(Color.primary)
                    Text("Done")
                        .font(.callout.weight(.medium))
                        .foregroundColor(.primary)
                        .colorInvert()
                        .padding(.horizontal, 30)
                        .padding(8)
                }
                .fixedSize()
            }
            .buttonStyle(.plain)
            .foregroundColor(.black)
            .padding(.vertical, 10)
        }
    }
}
