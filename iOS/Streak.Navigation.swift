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
                        .font(.system(size: 24, weight: .regular))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                }
                .opacity(index == 0 ? 0.4 : 1)
                .disabled(index == 0)
                .padding(.leading)
                
                ZStack {
                    Capsule()
                        .fill(Color(white: 1, opacity: 0.2))
                    Progress(current: index, max: calendar.count - 1)
                        .stroke(Color.white, style: .init(lineWidth: 4, lineCap: .round))
                }
                .frame(height: 4)
                .padding(.horizontal)
                
                Button {
                    index += 1
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 24, weight: .regular))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                }
                .opacity(index == calendar.count - 1 ? 0.4 : 1)
                .disabled(index == calendar.count - 1)
                .padding(.trailing)
            }
            .background(Color.accentColor)
        }
    }
}
