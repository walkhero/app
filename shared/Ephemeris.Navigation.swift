import SwiftUI

extension Ephemeris {
    struct Navigation: View {
        @Binding var index: Int
        let monther: DateFormatter
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
                        .foregroundColor(.primary)
                        .frame(width: 50, height: 50)
                }
                .opacity(index == 0 ? 0.15 : 1)
                .disabled(index == 0)
                Text(verbatim: monther.string(from: Calendar.current.date(from: .init(month: month))!))
                    .font(Font.callout.bold())
                    .frame(width: 130)
                Button {
                    withAnimation(.spring(blendDuration: 0.5)) {
                        index += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.primary)
                        .frame(width: 50, height: 50)
                }
                .opacity(index == months - 1 ? 0.15 : 1)
                .disabled(index == months - 1)
            }
        }
    }
}
