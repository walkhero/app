import SwiftUI
import Combine

struct Map: View {
    weak var status: Status!
    @State private var started: Date?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Representable(status: status)
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, 220)
            
            ZStack(alignment: .topTrailing) {
                Button {
                    status.tools.toggle()
                } label: {
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 36, height: 36)
                        Circle()
                            .stroke(Color(.tertiaryLabel), lineWidth: 1)
                            .frame(width: 36, height: 36)
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.primary)
                    }
                    .contentShape(Rectangle())
                }
                .padding([.top, .trailing])
            }
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topTrailing)
            
            if started == nil {
                Card(status: status)
            } else {
                Placeholder()
            }
        }
        .onReceive(cloud) { model in
            started = model.walking
            
            if let date = started, !status.started {
                status.start(date: date)
            }
        }
        .sheet(isPresented: .init(get: { started != nil }, set: { _ in })) {
            Walking.Detent(status: status, started: started ?? .now)
                .equatable()
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
