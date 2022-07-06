import SwiftUI
import Hero

struct Main: View {
    let session: Session
    let chart: Chart
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Actions(chart: chart)
            Stats(session: session, chart: chart)
        }
    }
}
