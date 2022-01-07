import SwiftUI
import MapKit
import Combine
import Hero

extension Map {
    final class Representable: MKMapView, MKMapViewDelegate, UIViewRepresentable {
        private var centred = false
        private var subs = Set<AnyCancellable>()
        private let dispatch = DispatchQueue(label: "", qos: .utility)
        
        required init?(coder: NSCoder) { nil }
        init(center: PassthroughSubject<Void, Never>) {
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            mapType = .standard
            delegate = self
            setUserTrackingMode(.follow, animated: false)
            
            cloud
                .map(\.tiles)
                .first()
                .merge(with: cloud
                        .map(\.tiles)
                        .combineLatest(location.tiles) { .init(.init($0) + .init($1)) }
                        .throttle(for: .seconds(1), scheduler: dispatch, latest: true))
                .removeDuplicates()
                .map(\.overlay)
                .receive(on: DispatchQueue.main)
                .combineLatest(location.overlays)
                .sink { [weak self] overlay, show in
                    if let overlays = self?.overlays {
                        self?.removeOverlays(overlays)
                    }
                    if show {
                        self?.addOverlay(overlay, level: .aboveLabels)
                    }
                }
                .store(in: &subs)
            
            center
                .sink { [weak self] in
                    guard let coordinate = self?.userLocation.coordinate else { return }
                    self?.center(coordinate: coordinate)
                }
                .store(in: &subs)
        }
        
        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolygonRenderer(overlay: rendererFor)
            renderer.fillColor = .init(named: "Tile")
            return renderer
        }
        
        func mapView(_: MKMapView, didUpdate: MKUserLocation) {
            guard let coordinate = didUpdate.location?.coordinate else { return }
            if !centred {
                centred = true
                center(coordinate: coordinate)
            }
        }
        
        func makeUIView(context: Context) -> Representable {
            self
        }
        
        func updateUIView(_: Representable, context: Context) { }
        
        private func center(coordinate: CLLocationCoordinate2D) {
            setCamera(.init(lookingAtCenter: coordinate,
                            fromDistance: 2500,
                            pitch: 0,
                            heading: 0), animated: false)
            
            var point = convert(coordinate, toPointTo: self)
            point.y += (bounds.height - point.y) / 2
            camera.centerCoordinate = convert(point, toCoordinateFrom: self)
        }
    }
}
