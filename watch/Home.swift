import SwiftUI
import Archivable

struct Home: View {
    @Binding var session: Session
    @State private var last: DateInterval?
    
    var body: some View {
        ZStack {
            Label(last == nil
                    ? "New Hero"
                    : session.relative.string(from: last!.end, to: .init()),
                  systemImage: "figure.walk")
                .font(.footnote)
                .padding([.leading, .top])
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
            Button {
                Cloud.shared.start()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(
                                gradient: .init(colors: [.blue, .purple]),
                                startPoint: .top,
                                endPoint: .bottom))
                    Image(systemName: "figure.walk")
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                        .padding(12)
                    Image(systemName: "plus")
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomTrailing)
                        .padding(12)
                }
                .foregroundColor(.black)
                .font(.title3)
                .contentShape(Rectangle())
                .frame(width: 64, height: 64)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .onReceive(Cloud.shared.archive) {
            last = $0.last
        }
        .edgesIgnoringSafeArea(.all)
    }
}
