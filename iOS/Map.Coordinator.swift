import MapKit
import Combine
import Hero

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        private var subs = Set<AnyCancellable>()
        
        required init?(coder: NSCoder) { nil }
        init(wrapper: Map) {
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            pointOfInterestFilter = .includingAll
            mapType = .standard
            delegate = self
            setUserTrackingMode(.follow, animated: false)
            
            let tiler = Tiler(tiles: wrapper.tiles)
            addOverlay(tiler, level: .aboveRoads)
            
            wrapper.add?
                .debounce(for: .seconds(3), scheduler: DispatchQueue.global(qos: .utility))
                .removeDuplicates()
                .sink {
                    tiler.add($0)
                }.store(in: &subs)
            
            var region = MKCoordinateRegion()
            region.center = userLocation.location == nil ? centerCoordinate : userLocation.coordinate
            region.span = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            setRegion(region, animated: false)
        }
        
        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
            (rendererFor as! Tiler).renderer
        }
    }
}
