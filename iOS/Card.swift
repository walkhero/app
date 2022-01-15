import SwiftUI
import Hero

struct Card: View {
    weak var status: Status!
    let started: Date?
    @State private var summary: Summary?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26)
                .fill(Color(.systemBackground))
                .shadow(color: .init("Shadow"), radius: 10)
            RoundedRectangle(cornerRadius: 26)
                .fill(Color(.tertiarySystemBackground))
                .padding(1)
            VStack(spacing: 0) {
                if let started = started {
                    Walking(status: status,
                            summary: $summary,
                            started: started)
                } else {
                    Home()
                }
            }
        }
        .sheet(item: $summary) { result in
            Sheet(rootView: Confirm(summary: result) {
                summary = nil
            })
        }
    }
}
