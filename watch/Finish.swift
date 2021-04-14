import SwiftUI
import Hero

struct Finish: View {
    @Binding var session: Session
    @Binding var transport: Transport?
    
    var body: some View {
        ScrollView {
            VStack {
                Text(verbatim: session.components.string(from: session.archive.last!.duration) ?? "")
                    .font(Font.title3.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("DURATION")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
                if session.archive.enrolled(.streak) {
                    Text(NSNumber(value: transport?.streak ?? 0), formatter: session.decimal)
                        .font(Font.title3.bold())
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.top)
                    Text("STREAK")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom)
                }
                if session.archive.enrolled(.steps) {
                    Text(NSNumber(value: transport?.steps ?? 0), formatter: session.decimal)
                        .font(Font.title3.bold())
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.top)
                    Text("STEPS")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom)
                }
                if session.archive.enrolled(.distance) {
                    Text(Measurement(value: .init(transport?.distance ?? 0), unit: UnitLength.meters), formatter: session.measures)
                        .font(Font.title3.bold())
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.top)
                    Text("DISTANCE")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom)
                }
                if session.archive.enrolled(.map) {
                    Text(NSNumber(value: transport?.map ?? 0), formatter: session.decimal)
                        .font(Font.title3.bold())
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.top)
                    Text("MAP SQUARES")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom)
                }
            }
            .padding(.trailing)
            .padding(.trailing)
            .padding(.bottom)
            .padding(.bottom)
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
