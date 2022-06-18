import SwiftUI

struct Mapper: View {
    @ObservedObject var walker: Walker
    @StateObject private var map = Map()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        map
            .edgesIgnoringSafeArea(.all)
            .safeAreaInset(edge: .top, spacing: 0) {
                HStack {
                    Button {
                        map.center()
                    } label: {
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 30, weight: .ultraLight))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.white)
                            .frame(width: 65, height: 65)
                            .contentShape(Rectangle())
                    }
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.white)
                            .frame(width: 65, height: 65)
                            .contentShape(Rectangle())
                    }
                }
            }
            .onChange(of: walker.overlay) {
                map.update(overlay: $0)
            }
            .onAppear {
                map.update(overlay: walker.overlay)
            }
    }
}
