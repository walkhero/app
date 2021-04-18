import SwiftUI
import Hero

struct Finish: View {
    @Binding var session: Session
    @Binding var finish: Hero.Finish?
    
    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .font(.largeTitle)
            Spacer()
            Text(verbatim: session.components.string(from: finish?.duration ?? 0) ?? "")
                .font(Font.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            Text("DURATION")
                .font(.callout)
                .foregroundColor(.secondary)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                .padding(.bottom)
            if session.archive.enrolled(.streak) {
                Text(NSNumber(value: finish?.streak ?? 0), formatter: session.decimal)
                    .font(Font.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("STREAK")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
            }
            if session.archive.enrolled(.steps) {
                Text(NSNumber(value: finish?.steps ?? 0), formatter: session.decimal)
                    .font(Font.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("STEPS")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
            }
            if session.archive.enrolled(.distance) {
                Text(Measurement(value: .init(finish?.distance ?? 0), unit: UnitLength.meters), formatter: session.measures)
                    .font(Font.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("DISTANCE")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
            }
            if session.archive.enrolled(.map) {
                Text(NSNumber(value: finish?.map ?? 0), formatter: session.decimal)
                    .font(Font.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("MAP SQUARES")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
            }
            Spacer()
            
            Control(title: "DONE", gradient: .init(
                        gradient: .init(colors: [.blue, .init(.systemIndigo)]),
                        startPoint: .leading,
                        endPoint: .trailing)) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    finish = nil
                }
            }
        }
        .padding(30)
    }
}
