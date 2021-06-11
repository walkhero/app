import SwiftUI
import Hero

struct Finish: View {
    @Binding var session: Session
    let finish: Hero.Finish
    
    var body: some View {
        ScrollView {
            VStack {
                Text(verbatim: session.components.string(from: finish.duration) ?? "")
                    .font(.title3.bold())
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("DURATION")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
                if Cloud.shared.archive.value.enrolled(.streak) {
                    Text(NSNumber(value: finish.streak), formatter: session.decimal)
                        .font(.title3.bold())
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.top)
                    Text("STREAK")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom)
                }
                if Cloud.shared.archive.value.enrolled(.steps) {
                    Text(NSNumber(value: finish.steps), formatter: session.decimal)
                        .font(.title3.bold())
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.top)
                    Text("STEPS")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom)
                }
                if Cloud.shared.archive.value.enrolled(.distance) {
                    Text(Measurement(value: .init(finish.metres), unit: UnitLength.meters), formatter: session.measures)
                        .font(.title3.bold())
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.top)
                    Text("DISTANCE")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                        .padding(.bottom)
                }
                if Cloud.shared.archive.value.enrolled(.map) {
                    Text(NSNumber(value: finish.area), formatter: session.decimal)
                        .font(.title3.bold())
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
                    session.section = .home
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
