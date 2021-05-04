import SwiftUI

extension Settings {
    struct Froob: View {
        @Binding var session: Session
        @Environment(\.presentationMode) private var visible
        
        var body: some View {
            VStack {
                Text("WalkHero+")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding()
                Text("""
Support the development of this app.

WalkHero is brought to you by a very small team wanting to make fun and challenging walking to be able to keep up with a healthy lifestyle without having to worry too much about it.

They also wanted to share it with you and others.

Making and maintaining an indie app is not easy, and we appreciate it if your situation allows you contribute for the cause.

WalkHero+ is an In-App Purchase, it is non-consumable, meaning it is a 1 time only purchase.
""")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                Spacer()
                Button {
                    visible.wrappedValue.dismiss()
                    session.purchases.open.send()
                } label: {
                    ZStack {
                        Capsule()
                            .fill(Color.blue)
                        Text("ACCEPT")
                            .font(.footnote.bold())
                            .foregroundColor(.white)
                    }
                    .frame(width: 140, height: 36)
                }
                .contentShape(Rectangle())
                .padding(.bottom)
            }
            .padding()
            .onReceive(session.dismiss) {
                visible.wrappedValue.dismiss()
            }
        }
    }
}
