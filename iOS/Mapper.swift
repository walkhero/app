import SwiftUI

struct Mapper: View {
    @StateObject var map = Map()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        map
            .edgesIgnoringSafeArea(.all)
            .safeAreaInset(edge: .top, spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 30, weight: .light))
                                .symbolRenderingMode(.hierarchical)
                                .frame(width: 54, height: 54)
                                .contentShape(Rectangle())
                        }
                    }
                    
                    Divider()
                }
                .background(.ultraThinMaterial)
            }
    }
}
