import SwiftUI
import Hero

struct Finish: View {
    @Binding var session: Session
    @Binding var transport: Transport?
    
    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .font(.largeTitle)
            Spacer()
            Text(verbatim: session.components.string(from: session.archive.last!.duration) ?? "")
                .font(Font.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            Text("DURATION")
                .font(.callout)
                .foregroundColor(.secondary)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                .padding(.bottom)
            if session.archive.enrolled(.streak) {
                Text(NSNumber(value: transport?.streak ?? 0), formatter: session.decimal)
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
                Text(NSNumber(value: transport?.steps ?? 0), formatter: session.decimal)
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
                Text(Measurement(value: .init(transport?.distance ?? 0), unit: UnitLength.meters), formatter: session.measures)
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
                Text(NSNumber(value: transport?.map ?? 0), formatter: session.decimal)
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
                    transport = nil
                }
            }
        }
        .padding(30)
    }
}
