import MapKit
import Combine
import Hero

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        let tiles = PassthroughSubject<Set<Tile>, Never>()
        private var subs = Set<AnyCancellable>()
        private var centred = false
        private let start = Date()
        
        required init?(coder: NSCoder) { nil }
        init(wrapper: Map) {
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            mapType = .standard
            delegate = self
            
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
            
            addOverlay(Set<Tile>().overlay)
        }
        
        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolygonRenderer(overlay: rendererFor)
            renderer.fillColor = .init(white: 0, alpha: UIApplication.dark ? 0.7 : 0.35)
            return renderer
        }
        
        func mapView(_: MKMapView, didUpdate: MKUserLocation) {
            guard let coordinate = didUpdate.location?.coordinate else { return }
            if !centred || Calendar.current.dateComponents([.second], from: start, to: .init()).second! < 3 {
                centred = true
                if abs(coordinate.latitude - region.center.latitude) > 0.01 ||
                    abs(coordinate.longitude - region.center.longitude) > 0.01 {
                    var region = MKCoordinateRegion()
                    region.center = coordinate
                    region.span = .init(latitudeDelta: 0.001, longitudeDelta: 0.001)
                    setRegion(region, animated: false)
                    setUserTrackingMode(.follow, animated: false)
                }
            }
        }
    }
}
