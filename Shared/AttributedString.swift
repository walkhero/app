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
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        var number = Self(formatter.string(from: .init(value: value)) ?? "")
        number.numberPart = .integer
        return number + .init(" walk")
    }
    
    static func metres(value: Int, digits: Int) -> Self {
        Measurement(value: .init(value), unit: UnitLength.meters)
            .formatted(.measurement(width: .wide,
                                    usage: .road,
                                    numberFormatStyle: .number
                .precision(.fractionLength(digits > 0 ? 1 ... digits : 0 ... 0)))
                .attributed)
    }
    
    static func calories(value: Int) -> Self {
        format(value: value, singular: "calorie", plural: "calories")
    }
    
    static func duration(value: Int) -> Self {
        var duration = Self((Date(timeIntervalSinceNow: -.init(value)) ..< .now)
            .formatted(.timeDuration))
        duration.numberPart = .integer
        return duration
    }
    
    static func duration(start: UInt32, current: Date) -> Self {
        var string = (.init(timestamp: start) ..< current).formatted(.timeDuration)
        
        switch string.count {
        case 1:
            string = "00:0" + string
        case 2:
            string = "00:" + string
        case 4:
            string = "0" + string
        default:
            break
        }
        
        var duration = Self(string)
        
        if Int(current.timeIntervalSince1970) % 2 == 1 {
            if let range = duration.range(of: ":") {
                duration[range].foregroundColor = .clear
            }
            if let range = duration.range(of: ":", options: [.backwards]) {
                duration[range].foregroundColor = .clear
            }
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
}
