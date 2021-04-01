import Foundation
import Hero

struct Session {
    var archive = Archive()
    let health = Health()
    let location = Location()
    let components = DateComponentsFormatter()
    let decimal = NumberFormatter()
    let measures = MeasurementFormatter()
    let percentil = NumberFormatter()
    
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
}
