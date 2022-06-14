//import SwiftUI
//import Hero
//
//extension Walking {
//    struct Stats: View {
//        @ObservedObject var status: Status
//        let squares: Set<Squares.Item>
//
//        var body: some View {
//            VStack {
//                Item(text: .init(status.steps, format: .number),
//                     title: "Steps")
//                
//                Item(text: .init(.init(value: .init(status.distance),
//                                       unit: UnitLength.meters),
//                                 format: .measurement(width: .abbreviated,
//                                                      usage: .general,
//                                                      numberFormatStyle: .number)),
//                     title: "Distance")
//                
//                Item(text: .init(status
//                                    .squares
//                                    .items
//                                    .subtracting(squares)
//                                    .count, format: .number),
//                     title: "Squares")
//            }
//            .edgesIgnoringSafeArea(.all)
//        }
//    }
//}
