import Foundation
import CoreLocation

final class Location: NSObject, CLLocationManagerDelegate {
    private var manager: CLLocationManager?
    
    func start() {
        let manager = CLLocationManager()
        manager.delegate = self
        self.manager = manager
    }
    
    func end() {
        manager = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization: CLAuthorizationStatus) {
        switch didChangeAuthorization {
            case .notDetermined: manager.requestAlwaysAuthorization()
            default: break
        }
    }
    
    func locationManager(_: CLLocationManager, didFailWithError: Error) { }
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) { }
    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) { }
}
