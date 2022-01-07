import SwiftUI
import Combine

struct Map: View {
    weak var status: Status!
    @State private var options = false
    private let center = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Representable(center: center)
                    .equatable()
                    .frame(height: options ? proxy.size.height * 0.55 : nil)
                    .edgesIgnoringSafeArea(.all)
                if options {
                    Spacer()
                }
            }
            .background(Color.black)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                options = true
            }
        }
        .sheet(isPresented: $options) {
            Options(status: status, center: center)
                .equatable()
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
