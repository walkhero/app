import SwiftUI

struct Indicator: View {
    let current: Int
    let max: Int
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.accentColor.opacity(0.3))
            Progress(current: current, max: max)
                .stroke(Color.accentColor, style: .init(lineWidth: 6, lineCap: .round))
        }
        .frame(height: 6)
        .padding(.leading)
    }
}
