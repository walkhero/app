import CoreGraphics
import Hero

struct Metrics {
    struct streak {
        struct header {
            static let width = CGFloat(100)
        }
        
        static let padding = CGFloat(20)
    }
    
    struct steps {
        static let min = 100
        static let padding = CGFloat(20)
    }
    
    struct distance {
        static let min = 1000
        static let padding = CGFloat(20)
    }
    
    struct map {
        static let tiles = pow(Double(4), 20)
    }
    
    struct home {
        struct picture {
            static let size = CGFloat(85)
        }
    }
    
    struct calendar {
        struct day {
            static let size = CGFloat(40)
            static let padding = CGFloat(5)
            static let padding2 = padding * 2
            static let radii = size / 2 - padding
            static let radius = CGSize(width: radii, height: radii)
            static let size_padding2 = size - padding2
        }
    }
    
    struct chart {
        static let limit = CGFloat(Constants.chart.max - 1)
    }
}
