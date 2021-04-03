import WidgetKit
import Hero

extension Streak {
    struct Provider: TimelineProvider {
        func placeholder(in: Context) -> Entry {
            .placeholder
        }

        func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
            completion(context.isPreview ? .placeholder : entry)
        }

        func getTimeline(in: Context, completion: @escaping (Timeline<Entry>) -> ()) {
            completion(.init(entries: [entry], policy: .never))
        }
        
        private var entry: Entry {
            guard let archive = Defaults.archive else { return .placeholder }
            let calendar = archive.calendar
            return .init(
                year: calendar.last!,
                streak: calendar.streak,
                today: archive.last != nil && Calendar.current.isDateInToday(archive.last!.start))
        }
    }
}
