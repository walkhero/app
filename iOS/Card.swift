import SwiftUI

struct Card: View {
    weak var status: Status!
    let started: Date?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.tertiarySystemBackground))
                .shadow(color: .black.opacity(0.25), radius: 5)
            VStack(spacing: 0) {
                if let started = started {
                    Walking(status: status, started: started)
                } else {
                    Home()
                }
            }
        }
    }
}
