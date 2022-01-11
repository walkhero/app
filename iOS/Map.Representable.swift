import SwiftUI
import MapKit
import Combine
import Hero

extension Map {
    final class Representable: MKMapView, MKMapViewDelegate, UIViewRepresentable {
        private weak var status: Status!
        private var first = true
        private var subs = Set<AnyCancellable>()
        private let dispatch = DispatchQueue(label: "", qos: .utility)
        
        required init?(coder: NSCoder) { nil }
        init(status: Status) {
            self.status = status
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            mapType = .standard
            delegate = self
            
            cloud
                .map(\.tiles)
                .first()
                .merge(with: cloud
                        .map(\.tiles)
                        .combineLatest(status.$tiles) { .init(.init($0) + .init($1)) }
                        .throttle(for: .seconds(1), scheduler: dispatch, latest: true))
                .removeDuplicates()
                .map(\.overlay)
                .receive(on: DispatchQueue.main)
                .combineLatest(status.$hide)
                .sink { [weak self] overlay, hide in
                    if let overlays = self?.overlays {
                        self?.removeOverlays(overlays)
                    }
                    if hide {
                        self?.addOverlay(overlay, level: .aboveLabels)
                    }
                }
                .store(in: &subs)
            
            status
                .$follow
                .dropFirst()
                .sink { [weak self] in
                    self?.setUserTrackingMode($0 ? .follow : .none, animated: true)
                }
                .store(in: &subs)
        }
        
        func mapView(_: MKMapView, didUpdate: MKUserLocation) {
            guard first else { return }
            first = false
            setUserTrackingMode(Defaults.shouldFollow ? .follow : .none, animated: true)
        }
        
        func mapView(_: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
            Defaults.shouldFollow = mode == .follow
            status.follow = mode == .follow
        }
        
        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolygonRenderer(overlay: rendererFor)
            renderer.fillColor = .init(named: "Tile")
            return renderer
        }
        
        func makeUIView(context: Context) -> Representable {
            self
        }
        
        func updateUIView(_: Representable, context: Context) { }
    }
}
