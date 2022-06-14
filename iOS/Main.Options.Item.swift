//import SwiftUI
//
//extension Main.Options {
//    struct Item: View {
//        let font: Font
//        let symbol: String
//        let active: Bool
//        let action: () -> Void
//        
//        var body: some View {
//            Button(action: action) {
//                ZStack {
//                    Circle()
//                        .fill(active ? .ultraThickMaterial : .ultraThinMaterial)
//                        .frame(width: 40, height: 40)
//                    Circle()
//                        .stroke(active ? .secondary : Color(.tertiaryLabel), lineWidth: 1)
//                        .frame(width: 39.5, height: 39.5)
//                    Image(systemName: symbol)
//                        .font(font.weight(.light))
//                        .symbolRenderingMode(.hierarchical)
//                        .foregroundColor(active ? .accentColor : .secondary)
//                }
//                .contentShape(Rectangle())
//            }
//            .padding([.top, .trailing])
//        }
//    }
//}
