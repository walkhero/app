import SwiftUI

extension AttributedString {
    static func streak(value: Int) -> Self {
        .init(value.formatted() + " streak")
    }
    
    static func walks(value: Int) -> Self {
        .init(value.formatted() + (value == 1 ? " walk" : " walks"))
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
                value[run.range].foregroundColor = .primary
                value[run.range].font = .title2.monospacedDigit().weight(.regular)
            }
        }
        return value
    }
}
