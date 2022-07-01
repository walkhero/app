import SwiftUI

extension AttributedString {
    static func plain(value: Int) -> Self {
        var number = Self(value.formatted())
        number.numberPart = .integer
        return number
    }
    
    static func streak(value: Int) -> Self {
        var number = Self(value.formatted())
        number.numberPart = .integer
        return number + .init(" streak")
    }
    
    static func days(value: Int) -> Self {
        format(value: value, singular: "day", plural: "days")
    }
    
    static func walks(value: Int) -> Self {
        format(value: value, singular: "walk", plural: "walks")
    }
    
    static func steps(value: Int) -> Self {
        format(value: value, singular: "step", plural: "steps")
    }
    
    static func squares(value: Int) -> Self {
        format(value: value, singular: "square", plural: "squares")
    }
    
    static func ordinal(value: Int) -> Self {
        var number = Self(value.formatted())
        number.numberPart = .integer
        return .init("#") + number
    }
    
    static func metres(value: Int, fraction: Bool) -> Self {
        Measurement(value: .init(value), unit: UnitLength.meters)
            .formatted(.measurement(width: metresWidth,
                                    usage: .road,
                                    numberFormatStyle: .number
                .precision(.fractionLength(fraction ? 0 ... 1 : 0 ... 0)))
                .attributed)
    }
    
    static func calories(value: Int, caption: Bool) -> Self {
        let value = Int(Double(value) / 1000)
        
        if caption {
            return format(value: value, singular: "calorie", plural: "calories")
        } else {
            return plain(value: value)
        }
    }
    
    static func duration(value: Int) -> Self {
        var duration = Self((Date(timeIntervalSinceNow: -.init(value)) ..< .now)
            .formatted(.timeDuration)
            .zeroPad)
        duration.numberPart = .integer
        return duration
    }
    
    static func duration(start: UInt32, current: Date) -> Self {
        var duration = Self((.init(timestamp: start) ..< current)
            .formatted(.timeDuration)
            .zeroPad)
        
        [duration.range(of: ":"),
         duration.range(of: ":", options: [.backwards])]
            .compactMap { $0 }
            .forEach {
                if Int(current.timeIntervalSince1970) % 2 == 1 {
                    duration[$0].foregroundColor = .clear
                }
                
                duration[$0].font = .system(size: 32, weight: .regular)
            }
        
        return duration
    }
    
    private static func format(value: Int, singular: String, plural: String) -> Self {
        var number = Self(value.formatted())
        number.numberPart = .integer
        return number + .init(value == 1 ? " " + singular : " " + plural)
    }
    
    func numeric(font: Font, color: Color) -> Self {
        var value = self
        value.runs.forEach { run in
            if run.numberPart != nil || run.numberSymbol != nil {
                value[run.range].foregroundColor = color
                value[run.range].font = font
            }
        }
        return value
    }
    
#if os(watchOS)
    private static var metresWidth: Measurement<UnitLength>.FormatStyle.UnitWidth {
        .abbreviated
    }
#else
    private static var metresWidth: Measurement<UnitLength>.FormatStyle.UnitWidth {
        .wide
    }
#endif
}

private extension String {
    var zeroPad: Self {
        switch count {
        case 1:
            return "00:0" + self
        case 2:
            return "00:" + self
        case 4:
            return "0" + self
        default:
            return self
        }
    }
}
