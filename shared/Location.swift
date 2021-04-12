import Foundation
import CoreLocation
import Combine
import Hero

final class Location: NSObject, CLLocationManagerDelegate {
    let tiles = PassthroughSubject<Tile, Never>()
    private var manager: CLLocationManager?
    
    func enrollIfNeeded() {
        if CLLocationManager().authorizationStatus == .notDetermined {
            enroll()
        }
    }
    
    func start(_ archive: Archive) {
        guard archive.enrolled(.map) else { return }
        enroll()
        manager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager!.allowsBackgroundLocationUpdates = true
        manager!.startUpdatingLocation()
        
        #if os(iOS)
        manager!.showsBackgroundLocationIndicator = true
        manager!.startMonitoringSignificantLocationChanges()
        #endif
    }
    
    func end() {
        #if os(iOS)
        manager?.stopMonitoringSignificantLocationChanges()
        #endif
        
        manager?.stopUpdatingLocation()
        manager = nil
    }
    
    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        didUpdateLocations.last.map(\.coordinate.tile).map(tiles.send)
    }
    
    func locationManager(_: CLLocationManager, didChangeAuthorization: CLAuthorizationStatus) { }
    func locationManager(_: CLLocationManager, didFailWithError: Error) { }
    
    #if os(iOS)
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
    #endif
    
    private func enroll() {
        guard manager == nil else { return }
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        self.manager = manager
    }
}
