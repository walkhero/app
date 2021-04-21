import Foundation
import Hero

struct Session {
    var archive = Archive.new
    var section = Section.home
    let health = Health()
    let location = Location()
    let components = DateComponentsFormatter()
    let decimal = NumberFormatter()
    let measures = MeasurementFormatter()
    let percentil = NumberFormatter()
    let relative = RelativeDateTimeFormatter()
    
    init() {
        components.allowedUnits = [.minute, .second]
        components.unitsStyle = .positional
        components.zeroFormattingBehavior = .pad
        
        decimal.numberStyle = .decimal
        
        percentil.numberStyle = .percent
        percentil.minimumSignificantDigits = 1
        percentil.maximumSignificantDigits = 3
        
        measures.unitStyle = .short
        measures.unitOptions = .naturalScale
        measures.numberFormatter.maximumFractionDigits = 1
    }
    
    func clear() {
        health.clear()
        location.end()
    }
}
