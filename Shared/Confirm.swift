import SwiftUI
import Hero

struct Confirm: View {
    let summary: Summary
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
            
            Item(text: .init(summary.streak, format: .number), title: "Streak")
                .padding(.top, 10)
            Item(text: .init((summary.started ..< .now).formatted(.timeDuration)), title: "Duration")
            Item(text: .init(summary.steps, format: .number), title: "Steps")
            Item(text: .init(.init(value: .init(summary.metres),
                             unit: UnitLength.meters),
                       format: .measurement(width: .abbreviated,
                                            usage: .general,
                                            numberFormatStyle: .number)), title: "Distance")
            Item(text: .init(summary.squares, format: .number), title: "Squares")
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
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .foregroundColor(.black)
            .padding(.vertical, 10)
        }
    }
}
