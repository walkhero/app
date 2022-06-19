import SwiftUI
import Dater

extension Streak {
    struct Navigation: View {
        @Binding var index: Int
        let calendar: [Days<Bool>]
        
        var body: some View {
            HStack(spacing: 0) {
                Button {
                    index -= 1
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 30, weight: .regular))
                        .symbolRenderingMode(.hierarchical)
                        .frame(width: 40, height: 60)
                        .padding(.leading)
                        .contentShape(Rectangle())
                }
                .opacity(index == 0 ? 0.6 : 1)
                .disabled(index == 0)
                
                Text(Calendar.current.date(from: .init(year: calendar[index].year,
                                                       month: calendar[index].month))!,
                     format: .dateTime.year().month(.wide))
                        .font(.body.weight(.medium))
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                        .foregroundColor(.primary)
                        .allowsHitTesting(false)
                
                Button {
                    index += 1
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 30, weight: .regular))
                        .symbolRenderingMode(.hierarchical)
                        .frame(width: 40, height: 60)
                        .padding(.trailing)
                        .contentShape(Rectangle())
                }
                .opacity(index == calendar.count - 1 ? 0.6 : 1)
                .disabled(index == calendar.count - 1)
            }
        }
    }
}
