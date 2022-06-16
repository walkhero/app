import SwiftUI

extension AttributedString {
    static func streak(value: Int) -> Self {
        var number = Self(value.formatted())
        number.numberPart = .integer
        return number + .init(" streak")
    }
    
    static func walks(value: Int) -> Self {
        var number = Self(value.formatted())
        number.numberPart = .integer
        return number + .init(value == 1 ? " walk" : " walks")
    }
    
    static func metres(value: Int, digits: ClosedRange<Int>) -> Self {
        Measurement(value: .init(value), unit: UnitLength.meters)
            .formatted(.measurement(width: .wide,
                                    usage: .road,
                                    numberFormatStyle: .number
                .precision(.significantDigits(digits)))
                .attributed)
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
