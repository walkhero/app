import CoreGraphics

struct Metrics {
    struct streak {
        struct header {
            static let width = CGFloat(100)
        }
    }
    
    struct calendar {
        struct day {
            static let size = CGFloat(45)
            static let padding = CGFloat(5)
            static let padding2 = padding * 2
            static let radii = size / 2 - padding
            static let radius = CGSize(width: radii, height: radii)
            static let size_padding2 = size - padding2
        }
    }
    
    struct chart {
        static let horizontal = 12
        static let vertical = 20
        static let max = CGFloat(vertical - 1)
    }
}
