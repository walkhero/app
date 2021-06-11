import SwiftUI
import Hero

extension Detail.Streak {
    struct Header: View {
        @Binding var session: Session
        let streak: Streak
        
        var body: some View {
            HStack(alignment: .bottom, spacing: 0) {
                Text(NSNumber(value: streak.maximum), formatter: session.decimal)
                    .frame(width: Metrics.streak.header.width)
                Text(NSNumber(value: streak.current), formatter: session.decimal)
                    .frame(width: Metrics.streak.header.width)
                Image(systemName: today ? "checkmark.circle.fill" : "exclamationmark.square.fill")
                    .foregroundColor(.primary)
                    .frame(width: Metrics.streak.header.width)
            }
            .font(.title.bold())
            .padding(.top, 10)
            .padding(.bottom, 1)
            HStack(spacing: 0) {
                Text("MAX")
                    .foregroundColor(.secondary)
                    .frame(width: Metrics.streak.header.width)
                Text("CURRENT")
                    .foregroundColor(.secondary)
                    .frame(width: Metrics.streak.header.width)
                Text("TODAY")
                    .foregroundColor(.accentColor)
                    .frame(width: Metrics.streak.header.width)
            }
            .font(.footnote)
        }
        
        private var today: Bool {
            session.archive.last != nil && Calendar.current.isDateInToday(session.archive.last!.start)
        }
    }
}
