//import SwiftUI
//import Hero
//
//extension Walking {
//    struct Controls: View {
//        weak var status: Status!
//        @Binding var summary: Summary?
//        let started: Date
//        @State private var alert = false
//        
//        var body: some View {
//            ZStack {
//                VStack {
//                    Button {
//                        alert = true
//                    } label: {
//                        Text("Cancel")
//                            .font(.callout)
//                            .padding(.leading)
//                            .contentShape(Rectangle())
//                    }
//                    .buttonStyle(.plain)
//                    .foregroundColor(.pink)
//                    .font(.callout)
//                    .alert("Cancel walk?", isPresented: $alert) {
//                        Button("Continue", role: .cancel) {
//                            
//                        }
//                        
//                        Button("Cancel", role: .destructive) {
//                            Task {
//                                await status.cancel()
//                            }
//                        }
//                    }
//                    Spacer()
//                }
//                
//                Button {
//                    Task {
//                        summary = await status.finish()
//                    }
//                } label: {
//                    ZStack {
//                        Capsule()
//                            .fill(Color.accentColor)
//                        Text("Finish")
//                            .font(.callout.weight(.medium))
//                            .padding(.horizontal, 30)
//                            .padding()
//                    }
//                    .fixedSize()
//                    .contentShape(Rectangle())
//                }
//                .buttonStyle(.plain)
//                .foregroundColor(.white)
//                .padding(.top, 20)
//            }
//        }
//    }
//}
