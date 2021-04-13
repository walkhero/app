import SwiftUI
import Hero

struct Finish: View {
    @Binding var session: Session
    @Binding var transport: Transport?
    
    var body: some View {
        ScrollView {
            if session.archive.enrolled(.streak) {
                Text(NSNumber(value: transport?.streak ?? 0), formatter: session.decimal)
                    .font(Font.title2.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .top])
                    .padding(.trailing)
                Text("STREAK")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .bottom])
                    .padding(.trailing)
            }
            if session.archive.enrolled(.steps) {
                Text(NSNumber(value: transport?.steps ?? 0), formatter: session.decimal)
                    .font(Font.title2.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .top])
                    .padding(.trailing)
                Text("STEPS")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .bottom])
                    .padding(.trailing)
            }
            if session.archive.enrolled(.distance) {
                Text(Measurement(value: .init(transport?.distance ?? 0), unit: UnitLength.meters), formatter: session.measures)
                    .font(Font.title2.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .top])
                    .padding(.trailing)
                Text("DISTANCE")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .bottom])
                    .padding(.trailing)
            }
            if session.archive.enrolled(.map) {
                Text(NSNumber(value: transport?.map ?? 0), formatter: session.decimal)
                    .font(Font.title2.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .top])
                    .padding(.trailing)
                Text("MAP SQUARES")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding([.trailing, .bottom])
                    .padding(.trailing)
            }
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    transport = nil
                }
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.primary)
                    Text("DONE")
                        .font(.callout)
                        .fontWeight(.medium)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 6)
                        .foregroundColor(.primary)
                        .colorInvert()
                }
                .fixedSize()
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.vertical)
        }
    }
}
