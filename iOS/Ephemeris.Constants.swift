import CoreGraphics

extension Ephemeris {
    struct Constants {
        static let size = CGFloat(40)
        static let padding = CGFloat(5)
        static let padding2 = padding * 2
        static let radii = size / 2 - padding
        static let radius = CGSize(width: radii, height: radii)
        static let size_padding2 = size - padding2
    }
}
