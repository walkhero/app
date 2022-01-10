import SwiftUI
import Combine

struct Map: View {
    weak var status: Status!
    weak var health: Health!
    @State private var options = false
    
    var body: some View {
        GeometryReader { proxy in
            if UIDevice.current.userInterfaceIdiom == .phone {
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
            } else {
                Representable()
                    .equatable()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                options = true
            }
        }
        .sheet(isPresented: $options) {
            Options(status: status, health: health)
                .equatable()
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
