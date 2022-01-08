import SwiftUI
import Combine

struct Map: View {
    weak var status: Status!
    @State private var options = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Representable()
                    .equatable()
                    .frame(height: options ? proxy.size.height * 0.6 : nil)
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
            Options(status: status)
                .equatable()
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
