import SwiftUI
import Hero

extension Ephemeris {
    struct Navigation: View {
        @Binding var index: Int
        let calendar: [Days]
        
        var body: some View {
            HStack {
                Button {
                    index -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                }
                .opacity(index == 0 ? 0.15 : 1)
                .disabled(index == 0)
                
                Text(Calendar.current.date(from: .init(year: calendar[index].year, month: calendar[index].month))!,
                     format: .dateTime.year().month(.wide))
                        .font(.footnote)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                        .foregroundColor(.primary)
                        .allowsHitTesting(false)
                
                Button {
                    index += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                }
                .opacity(index == calendar.count - 1 ? 0.15 : 1)
                .disabled(index == calendar.count - 1)
            }
        }
    }
}
