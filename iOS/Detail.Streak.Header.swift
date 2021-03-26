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
                Image(systemName: today ? "checkmark.circle.fill" : "slash.circle")
                    .font(.title2)
                    .foregroundColor(today ? .primary : .init(.tertiaryLabel))
                    .frame(width: Metrics.streak.header.width)
            }
            .padding(.top, 10)
            .padding(.bottom, 1)
            HStack(spacing: 0) {
                Text("MAX")
                    .frame(width: Metrics.streak.header.width)
                Text("CURRENT")
                    .frame(width: Metrics.streak.header.width)
                Text("TODAY")
                    .frame(width: Metrics.streak.header.width)
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        
        private var today: Bool {
            session.archive.last != nil && Calendar.current.isDate(session.archive.last!.start, inSameDayAs: .init())
        }
    }
}
