import SwiftUI

struct Indicator: View {
    let current: Int
    let max: Int
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.black)
            Progress(current: current, max: max)
                .stroke(Color.accentColor, style: .init(lineWidth: 4, lineCap: .round))
        }
        .frame(height: 4)
    }
}

