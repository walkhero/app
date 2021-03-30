import MapKit
import Combine
import Hero

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        private var subs = Set<AnyCancellable>()
        private let dark = UIImage(named: "dark")!.pngData()!
        
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
            
            wrapper.tiles.sink { [weak self] in
                guard let self = self else { return }
                self.removeOverlays(self.overlays)
                self.addOverlay(Tiler(tiles: $0, dark: self.dark), level: .aboveLabels)
            }.store(in: &subs)
            
            var region = MKCoordinateRegion()
            region.center = userLocation.location == nil ? centerCoordinate : userLocation.coordinate
            region.span = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            setRegion(region, animated: false)
        }
        
        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
            MKTileOverlayRenderer(tileOverlay: rendererFor as! Tiler)
        }
    }
}
