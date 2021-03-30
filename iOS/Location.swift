import Foundation
import CoreLocation
import Combine
import Hero

final class Location: NSObject, CLLocationManagerDelegate {
    let tiles = PassthroughSubject<Tile, Never>()
    private var manager: CLLocationManager?
    
    func start(_ archive: Archive) {
        guard archive.enrolled(.map) else { return }
        enroll()
        manager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager!.allowsBackgroundLocationUpdates = true
        manager!.showsBackgroundLocationIndicator = true
        manager!.startUpdatingLocation()
        manager!.startMonitoringSignificantLocationChanges()
    }
    
    func enroll() {
        guard manager == nil else { return }
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        self.manager = manager
    }
    
    func end() {
        manager?.stopMonitoringSignificantLocationChanges()
        manager?.stopUpdatingLocation()
        manager = nil
    }
    
    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        didUpdateLocations.last.map(\.coordinate.tile).map(tiles.send)
    }
    
    func locationManager(_: CLLocationManager, didChangeAuthorization: CLAuthorizationStatus) { }
    func locationManager(_: CLLocationManager, didFailWithError: Error) { }
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
}
