import SwiftUI

extension Ephemeris.Month {
    struct Day: View {
        let index: Int
        let continouos: Continuous
        
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
                        .fill(Color.accentColor)
                case .middle:
                    Rectangle()
                        .fill(Color.accentColor)
                        .padding(.vertical, 5)
                case .trailing:
                    Path(UIBezierPath(
                            roundedRect: CGRect(x: 0,
                                                y: Metrics.calendar.day.padding,
                                                width: Metrics.calendar.day.size,
                                                height: Metrics.calendar.day.size_padding2),
                            byRoundingCorners: [.topRight, .bottomRight],
                            cornerRadii: Metrics.calendar.day.radius).cgPath)
                        .fill(Color.accentColor)
                default:
                    EmptyView()
                }
                Text("\(index)")
                    .fontWeight(continouos == .none ? .regular : .bold)
                    .foregroundColor(continouos == .none ? .secondary : .white)
            }
            .frame(width: Metrics.calendar.day.size, height: Metrics.calendar.day.size)
        }
    }
}
