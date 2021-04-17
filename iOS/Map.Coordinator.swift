import MapKit
import Combine
import Hero

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        let tiles = PassthroughSubject<Set<Tile>, Never>()
        private var subs = Set<AnyCancellable>()
        private var centred = false
        private let dispatch = DispatchQueue(label: "", qos: .utility)
        
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
                .throttle(for: .seconds(1), scheduler: dispatch, latest: true)
                .removeDuplicates()
                .map(\.overlay)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    print("trot")
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
            renderer.fillColor = .init(white: 0, alpha: UIApplication.dark ? 0.65 : 0.3)
            return renderer
        }
        
        func mapView(_: MKMapView, didUpdate: MKUserLocation) {
            guard let coordinate = didUpdate.location?.coordinate else { return }
            if !centred {
                centred = true
                setCamera(MKMapCamera(lookingAtCenter: coordinate, fromDistance: 500, pitch: 0, heading: 0), animated: false)
            } else if abs(coordinate.latitude - region.center.latitude) + abs(coordinate.longitude - region.center.longitude) > 0.00075 {
                setCenter(coordinate, animated: true)
            }
        }
    }
}
