import WidgetKit
import SwiftUI

struct Streak: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "STREAK", provider: Provider()) { entry in
            Content(entry: entry)
        }
        .configurationDisplayName("STREAK")
        .description("Overview of this month")
        .supportedFamilies([.systemLarge])
    }
}
