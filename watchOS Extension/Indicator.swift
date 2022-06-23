import SwiftUI

struct Indicator: View {
    let current: Int
    let max: Int
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.quaternary)
            Progress(current: current, max: max)
                .stroke(Color.accentColor, style: .init(lineWidth: 5, lineCap: .round))
        }
        .frame(height: 5)
        .padding(.leading)
    }
}
