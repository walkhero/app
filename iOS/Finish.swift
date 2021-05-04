import SwiftUI
import Archivable
import Hero

struct Finish: View {
    @Binding var session: Session
    let finish: Hero.Finish
    
    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .font(.largeTitle)
            Spacer()
            Text(verbatim: session.components.string(from: finish.duration) ?? "")
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            Text("DURATION")
                .font(.callout)
                .foregroundColor(.secondary)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                .padding(.bottom)
            if Cloud.shared.archive.value.enrolled(.streak) {
                Text(NSNumber(value: finish.streak), formatter: session.decimal)
                    .font(.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("STREAK")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
            }
            if Cloud.shared.archive.value.enrolled(.steps) {
                Text(NSNumber(value: finish.steps), formatter: session.decimal)
                    .font(.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("STEPS")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
            }
            if Cloud.shared.archive.value.enrolled(.distance) {
                Text(Measurement(value: .init(finish.metres), unit: UnitLength.meters), formatter: session.measures)
                    .font(.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.top)
                Text("DISTANCE")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    .padding(.bottom)
            }
            if Cloud.shared.archive.value.enrolled(.map) {
                Text(NSNumber(value: finish.area), formatter: session.decimal)
                    .font(.title.bold())
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
                    session.section = .home
                }
            }
        }
        .padding(30)
    }
}
