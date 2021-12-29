import CoreLocation
import Combine
import Hero

final class Location: NSObject, CLLocationManagerDelegate {
    let tiles = CurrentValueSubject<Set<Tile>, Never>([])
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.allowsBackgroundLocationUpdates = true
    }
    
    func requestIfNeeded() {
        if CLLocationManager().authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        }
    }
    
    func start() {
        manager.startUpdatingLocation()
        
        #if os(iOS)
        manager.showsBackgroundLocationIndicator = true
        manager.startMonitoringSignificantLocationChanges()
        #endif
    }
    
    func end() {
        tiles.value = []
        
        #if os(iOS)
        manager.stopMonitoringSignificantLocationChanges()
        #endif
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        _ = didUpdateLocations
            .last
            .map(\.coordinate)
            .map(Tile.init(coordinate:))
            .map {
                tiles.value.insert($0)
            }
    }
    
    func locationManager(_: CLLocationManager, didChangeAuthorization: CLAuthorizationStatus) { }
    func locationManager(_: CLLocationManager, didFailWithError: Error) { }
    
    #if os(iOS)
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
    #endif
}
