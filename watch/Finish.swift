import SwiftUI
import Hero

struct Finish: View {
    @Binding var session: Session
    @Binding var finish: Hero.Finish?
    
    var body: some View {
        ScrollView {
            VStack {
                Text(verbatim: session.components.string(from: finish?.duration ?? 0) ?? "")
                    .font(Font.title3.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("DURATION")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
                if session.archive.enrolled(.streak) {
                    Text(NSNumber(value: finish?.streak ?? 0), formatter: session.decimal)
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
                    Text(NSNumber(value: finish?.steps ?? 0), formatter: session.decimal)
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
                    Text(Measurement(value: .init(finish?.metres ?? 0), unit: UnitLength.meters), formatter: session.measures)
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
                    Text(NSNumber(value: finish?.area ?? 0), formatter: session.decimal)
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
                    finish = nil
                }
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.primary)
                    Text("DONE")
                        .font(.callout)
                        .fontWeight(.medium)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 6)
                        .foregroundColor(.primary)
                        .colorInvert()
                }
                .fixedSize()
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.vertical)
            .padding(.vertical)
        }
    }
}
