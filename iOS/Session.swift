import Foundation
import Combine
import Hero

struct Session {
    var modal: Modal?
    var archive = Archive.new
    var player = Player()
    var section = Section.home
    let game = Game()
    let health = Health()
    let location = Location()
    let watch = Watch()
    let purchases = Purchases()
    let dismiss = PassthroughSubject<Void, Never>()
    let components = DateComponentsFormatter()
    let relative = RelativeDateTimeFormatter()
    let monther = DateFormatter()
    let weeker = DateFormatter()
    let decimal = NumberFormatter()
    let percentil = NumberFormatter()
    let measures = MeasurementFormatter()
    let challenges: AnyPublisher<Transport, Never>
    
    init() {
        challenges = Repository.memory
            .archive
            .zip(watch
                    .challenges)
            .map(\.1)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
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
