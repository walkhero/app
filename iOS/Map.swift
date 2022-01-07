import SwiftUI
import Combine

struct Map: View {
    weak var status: Status!
    private let center = PassthroughSubject<Void, Never>()
    
    var body: some View {
        Representable(center: center)
            .equatable()
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: .constant(true)) {
                Options(status: status, center: center)
                    .equatable()
                    .edgesIgnoringSafeArea(.bottom)
            }
    }
}
