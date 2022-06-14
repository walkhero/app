//import SwiftUI
//
//extension Stats {
//    struct Today: View {
//        let updated: DateInterval?
//        
//        var body: some View {
//            Section {
//                if updated == nil || !Calendar.current.isDateInToday(updated!.start) {
//                    HStack {
//                        Spacer()
//                        Image(systemName: "exclamationmark.triangle.fill")
//                            .font(.title3)
//                            .foregroundColor(.pink)
//                        Text("No walk today")
//                            .font(.body)
//                        Spacer()
//                    }
//                    .foregroundColor(.secondary)
//                    .padding()
//                } else {
//                    HStack {
//                        Spacer()
//                        Image(systemName: "checkmark.circle.fill")
//                            .font(.title.weight(.light))
//                            .foregroundColor(.accentColor)
//                        Image(systemName: "figure.walk")
//                            .font(.title3.weight(.light))
//                        Spacer()
//                    }
//                    .padding()
//                }
//                
//                if let updated = updated {
//                    Item(text: .init(updated.end,
//                                     format: .relative(presentation: .named)),
//                         title: "Updated")
//                }
//            }
//            .allowsHitTesting(false)
//            .listRowBackground(Color.clear)
//        }
//    }
//}
