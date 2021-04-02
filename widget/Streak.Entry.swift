import WidgetKit
import Hero

extension Streak {
    struct Entry: TimelineEntry, Equatable {
        static let placeholder = Self(year: [Date()].calendar.first!, streak: .zero, today: false)
        
        let year: Year
        let streak: Hero.Streak
        let today: Bool
        let date = Date()
    }
}
