//import SwiftUI
//import Hero
//
//extension Stats {
//    struct Trend: View {
//        let trend: Chart.Trend
//        let text: Text
//        
//        var body: some View {
//            VStack {
//                Text("Average")
//                    .foregroundColor(.secondary)
//                    .font(.footnote.weight(.light))
//                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
//                    .padding(.trailing)
//                ZStack {
//                    RoundedRectangle(cornerRadius: 8)
//                        .foregroundColor(.accentColor.opacity(0.3))
//                    HStack {
//                        Spacer()
//                        symbol
//                        text
//                            .font(.body.weight(.light).monospacedDigit())
//                    }
//                    .padding()
//                }
//            }
//            .listRowBackground(Color.clear)
//        }
//        
//        private var symbol: some View {
//            switch trend {
//            case .increase:
//                return Image(systemName: "chevron.up")
//                    .font(.body.weight(.medium))
//                    .foregroundColor(.blue)
//            case .decrease:
//                return Image(systemName: "chevron.down")
//                    .font(.body.weight(.medium))
//                    .foregroundColor(.pink)
//            case .stable:
//                return Image(systemName: "ellipsis")
//                    .font(.body.weight(.medium))
//                    .foregroundColor(.indigo)
//            }
//        }
//    }
//}
