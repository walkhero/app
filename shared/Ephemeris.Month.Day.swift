import SwiftUI


extension Ephemeris.Month {
    struct Day: View {
        let index: Int
        let today: Bool
        let continouos: Continuous
        private let fill = Color.accentColor
        
        var body: some View {
            ZStack {
                switch continouos {
                case .single:
                    Circle()
                        .fill(Color.accentColor)
                        .frame(
                            width: Metrics.calendar.day.size_padding2,
                            height: Metrics.calendar.day.size_padding2)
                case .leading:
                    Path(UIBezierPath(
                            roundedRect: CGRect(x: 0,
                                                y: Metrics.calendar.day.padding,
                                                width: Metrics.calendar.day.size,
                                                height: Metrics.calendar.day.size_padding2),
                            byRoundingCorners: [.topLeft, .bottomLeft],
                            cornerRadii: Metrics.calendar.day.radius).cgPath)
                        .fill(fill)
                case .middle:
                    Rectangle()
                        .fill(fill)
                        .padding(.vertical, 5)
                case .trailing:
                    Path(UIBezierPath(
                            roundedRect: CGRect(x: 0,
                                                y: Metrics.calendar.day.padding,
                                                width: Metrics.calendar.day.size,
                                                height: Metrics.calendar.day.size_padding2),
                            byRoundingCorners: [.topRight, .bottomRight],
                            cornerRadii: Metrics.calendar.day.radius).cgPath)
                        .fill(fill)
                default:
                    if today {
                        Circle()
                            .fill(fill.opacity(0.25))
                            .frame(
                                width: Metrics.calendar.day.size_padding2,
                                height: Metrics.calendar.day.size_padding2)
                    }
                }
                Text("\(index)")
                    .font(.footnote)
                    .fontWeight(continouos == .none ? .regular : .bold)
                    .foregroundColor(today
                                        ? .white
                                        : continouos == .none ? .init(.tertiaryLabel) : .black)
            }
            .frame(width: Metrics.calendar.day.size, height: Metrics.calendar.day.size)
        }
    }
}
