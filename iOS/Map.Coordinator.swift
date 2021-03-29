import MapKit

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        required init?(coder: NSCoder) { nil }
        init(wrapper: Map) {
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            mapType = .standard
            
            var region = MKCoordinateRegion()
            region.center = userLocation.location == nil ? centerCoordinate : userLocation.coordinate
            region.span = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            setRegion(region, animated: false)
            
            delegate = self
            setUserTrackingMode(.follow, animated: true)
        }
        
        func mapView(_: MKMapView, didUpdate: MKUserLocation) {
            guard let location = didUpdate.location else { return }
            setCenter(location.coordinate, animated: true)
        }
    }
}
