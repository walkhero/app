import SwiftUI

struct Navigation: View {
    let status: Status
    
    var body: some View {
        VStack {
            Geo()
            Spacer()
            Text(256, format: .number)
                .font(.largeTitle.monospaced())
            Text("Streak")
                .font(.callout)
                .foregroundColor(.secondary)
            Spacer()
            Label("You haven't walked today", systemImage: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.footnote)
                .foregroundColor(.pink)
                .imageScale(.large)
            Spacer()
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Bar(status: status)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Header(status: status)
        }
    }
}
