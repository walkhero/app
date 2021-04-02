import Foundation
import Combine
import Hero

struct Session {
    var archive = Archive()
    var player = Player()
    var section = Section.home
    let game = Game()
    let health = Health()
    let location = Location()
    let watch = Watch()
    let dismiss = PassthroughSubject<Void, Never>()
    let components = DateComponentsFormatter()
    let relative = RelativeDateTimeFormatter()
    let monther = DateFormatter()
    let weeker = DateFormatter()
    let decimal = NumberFormatter()
    let percentil = NumberFormatter()
    let measures = MeasurementFormatter()
    let widget = Memory.shared.archive
        .merge(with: Memory.shared.save)
        .removeDuplicates()
        .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    
    init() {
        components.allowedUnits = [.minute, .second]
        components.unitsStyle = .positional
        components.zeroFormattingBehavior = .pad
        
        monther.dateFormat = "MMMM"
        
        weeker.dateFormat = "EEEEE"
        
        decimal.numberStyle = .decimal
        
        percentil.numberStyle = .percent
        percentil.minimumSignificantDigits = 1
        percentil.maximumSignificantDigits = 3
        
        measures.unitStyle = .long
        measures.unitOptions = .naturalScale
        measures.numberFormatter.maximumFractionDigits = 1
    }
    
    func clear() {
        health.clear()
        location.end()
    }
}
