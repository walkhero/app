import SwiftUI

struct Card: View {
    weak var status: Status!
    let started: Date?
    @State private var finish: Finish?
    
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
                            finish: $finish,
                            started: started)
                } else {
                    Home()
                }
            }
        }
        .sheet(item: $finish) { result in
            Sheet(rootView: Confirm(finish: result) {
                finish = nil
            })
        }
    }
}
