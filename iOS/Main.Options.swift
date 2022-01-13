import SwiftUI
import Hero

extension Main {
    struct Options: View {
        @ObservedObject var status: Status
        
        var body: some View {
            VStack(alignment: .trailing) {
                Item(font: status.follow ? .title3 : .body,
                     symbol: status.follow ? "location.fill.viewfinder" : "location",
                     active: status.follow) {
                    status.follow.toggle()
                }
                .onChange(of: status.follow) {
                    Defaults.shouldFollow = $0
                }
                
                Item(font: .body,
                     symbol: status.hide ? "square.2.stack.3d.top.filled" : "square.2.stack.3d",
                     active: status.hide) {
                    status.hide.toggle()
                }
                .onChange(of: status.hide) {
                    Defaults.shouldHide = $0
                }
            }
            .frame(maxWidth: .greatestFiniteMagnitude,
                   maxHeight: .greatestFiniteMagnitude,
                   alignment: .topTrailing)
        }
    }
}
