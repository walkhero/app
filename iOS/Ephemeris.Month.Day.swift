//import SwiftUI
//
//extension Ephemeris.Month {
//    struct Day: View {
//        let index: Int
//        let today: Bool
//        let continouos: Continuous
//        
//        var body: some View {
//            ZStack {
//                switch continouos {
//                case .single:
//                    Circle()
//                        .fill(Color.accentColor)
//                        .frame(width: 30, height: 30)
//                case .leading:
//                    Path(UIBezierPath(
//                            roundedRect: CGRect(x: 0,
//                                                y: 5,
//                                                width: 40,
//                                                height: 30),
//                            byRoundingCorners: [.topLeft, .bottomLeft],
//                            cornerRadii: .init(width: 15, height: 15)).cgPath)
//                        .fill(Color.accentColor)
//                case .middle:
//                    Rectangle()
//                        .fill(Color.accentColor)
//                        .padding(.vertical, 5)
//                case .trailing:
//                    Path(UIBezierPath(
//                            roundedRect: CGRect(x: 0,
//                                                y: 5,
//                                                width: 40,
//                                                height: 30),
//                            byRoundingCorners: [.topRight, .bottomRight],
//                            cornerRadii: .init(width: 15, height: 15)).cgPath)
//                        .fill(Color.accentColor)
//                default:
//                    if today {
//                        Circle()
//                            .fill(Color.accentColor.opacity(0.25))
//                            .frame(width: 30, height: 30)
//                    }
//                }
//                Text("\(index)")
//                    .font(.caption2)
//                    .fontWeight(today
//                                ? .bold
//                                : continouos == .none
//                                    ? .light
//                                    : .regular)
//                    .foregroundColor(today
//                                        ? .white
//                                        : continouos == .none
//                                            ? .init(.tertiaryLabel)
//                                            : .white)
//            }
//            .frame(width: 40, height: 40)
//        }
//    }
//}
