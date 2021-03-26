import SwiftUI
import Hero

extension Listed {
    struct Item: View {
        @Binding var session: Session
        let item: Walk.Listed
        @State private var percent = CGFloat()
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.date, formatter: session.relative)
                    Text(verbatim: session.components.string(from: item.duration) ?? "")
                        .foregroundColor(.secondary)
                }
                .font(.footnote)
                .padding(.vertical, 10)
                Spacer()
                ZStack(alignment: .leading) {
                    Bar(percent: 1)
                        .stroke(Color(.tertiarySystemBackground), style: .init(lineWidth: 8, lineCap: .round))
                    Bar(percent: .init(item.percent))
                        .stroke(Color.accentColor, style: .init(lineWidth: 8, lineCap: .round))
                }
                .frame(width: 100)
            }
            .padding(.horizontal)
        }
    }
}
