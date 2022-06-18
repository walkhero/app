import SwiftUI

extension AttributedString {
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
    
    static func metres(value: Int, digits: Int) -> Self {
        Measurement(value: .init(value), unit: UnitLength.meters)
            .formatted(.measurement(width: .wide,
                                    usage: .road,
                                    numberFormatStyle: .number
                .precision(.significantDigits(1 ... digits)))
                .attributed)
    }
    
    static func calories(value: Int, digits: Int) -> Self {
        Measurement(value: .init(value), unit: UnitEnergy.calories)
            .formatted(.measurement(width: .wide,
                                    usage: .workout,
                                    numberFormatStyle: .number
                .precision(.significantDigits(1 ... digits)))
                .attributed)
    }
    
    static func duration(start: UInt32, current: Date) -> Self {
        var duration = Self((.init(timestamp: start) ..< current).formatted(.timeDuration))
        
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
