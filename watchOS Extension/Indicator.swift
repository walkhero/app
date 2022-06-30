import SwiftUI

struct Indicator: View {
    let current: Int
    let max: Int
    let height: CGFloat
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.accentColor.opacity(0.3))
            Progress(current: current, max: max)
                .stroke(Color.accentColor, style: .init(lineWidth: height, lineCap: .round))
        }
        .frame(height: height)
        .padding(.leading)
    }
}
