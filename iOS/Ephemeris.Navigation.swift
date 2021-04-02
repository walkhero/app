import SwiftUI

extension Ephemeris {
    struct Navigation: View {
        @Binding var session: Session
        @Binding var index: Int
        let months: Int
        let month: Int
        
        var body: some View {
            HStack {
                Button {
                    withAnimation(.spring(blendDuration: 0.5)) {
                        index -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(index == 0 ? .init(.tertiaryLabel) : .primary)
                        .frame(width: 50, height: 50)
                }
                .disabled(index == 0)
                Text(verbatim: session.monther.string(from: Calendar.current.date(from: .init(month: month))!))
                    .font(Font.callout.bold())
                    .frame(width: 130)
                Button {
                    withAnimation(.spring(blendDuration: 0.5)) {
                        index += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(index == months - 1 ? .init(.tertiaryLabel) : .primary)
                        .frame(width: 50, height: 50)
                }
                .disabled(index == months - 1)
            }
            HStack(spacing: 0) {
                ForEach(0 ..< 7) {
                    Text(verbatim: session.weeker.string(
                            from: Calendar.current.date(
                                from: .init(
                                    weekday: $0 + Calendar.current.firstWeekday % 7,
                                    weekOfMonth: 1))!))
                        .frame(width: Metrics.calendar.day.size)
                }
            }
            .font(.callout)
            .foregroundColor(.pink)
            .padding(.vertical, 10)
        }
    }
}
