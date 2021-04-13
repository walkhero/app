import MapKit
import Combine
import Hero

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        let tiles = PassthroughSubject<Set<Tile>, Never>()
        private var subs = Set<AnyCancellable>()
        
        required init?(coder: NSCoder) { nil }
        init(wrapper: Map) {
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            mapType = .standard
            delegate = self
            setUserTrackingMode(.follow, animated: false)
            
            tiles
                .debounce(for: 1, scheduler: DispatchQueue.global(qos: .utility))
                .removeDuplicates()
                .map(\.overlay)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    if let overlays = self?.overlays {
                        self?.removeOverlays(overlays)
                    }
                    self?.addOverlay($0, level: .aboveLabels)
                }
                .store(in: &subs)
            
            var region = MKCoordinateRegion()
            region.center = userLocation.location == nil ? centerCoordinate : userLocation.coordinate
            region.span = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            setRegion(region, animated: false)
            
            addOverlay(Set<Tile>().overlay)
        }
        
        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolygonRenderer(overlay: rendererFor)
            renderer.fillColor = .init(white: 0, alpha: UIApplication.dark ? 0.8 : 0.45)
            return renderer
        }
        
        func mapView(_: MKMapView, didUpdate: MKUserLocation) {
            guard let location = didUpdate.location else { return }
            if abs(location.coordinate.latitude - region.center.latitude) > 0.1 ||
                abs(location.coordinate.longitude - region.center.longitude) > 0.1 {
                setCenter(location.coordinate, animated: false)
            }
        }
    }
}
