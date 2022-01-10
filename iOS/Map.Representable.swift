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
        init() {
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            mapType = .standard
            delegate = self
            setUserTrackingMode(.follow, animated: false)
            setCameraZoomRange(.init(maxCenterCoordinateDistance: 5000), animated: false)
            
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
            
            location
                .center
                .sink { [weak self] in
                    self?.setUserTrackingMode($0 ? .follow : .none, animated: true)
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
                setCamera(.init(lookingAtCenter: coordinate,
                                fromDistance: 500,
                                pitch: 0,
                                heading: 0), animated: false)
            }
        }
        
        func makeUIView(context: Context) -> Representable {
            self
        }
        
        func updateUIView(_: Representable, context: Context) { }
    }
}
