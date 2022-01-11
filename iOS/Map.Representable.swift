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
        init(status: Status) {
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
                .sink { [weak self] in
                    self?.setUserTrackingMode($0 ? .follow : .none, animated: true)
                }
                .store(in: &subs)
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            mapView
                .view(for: mapView.userLocation)?
                .detailCalloutAccessoryView = UIImageView(image: .init(systemName: "figure.walk"))
            mapView.userLocation.title = nil
            mapView.userLocation.subtitle = nil
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
                                fromDistance: 1000,
                                pitch: 0,
                                heading: 0), animated: false)
            }
        }
        
        func mapView(_: MKMapView, viewFor: MKAnnotation) -> MKAnnotationView? {
//            print("a")
            if viewFor === userLocation {
                let original = view(for: viewFor)
                original?.image = .init(systemName: "figure.walk")
                original?.canShowCallout = false
                original?.detailCalloutAccessoryView = UIImageView(image: UIImage(systemName: "figure.walk"))
                return original
            }
            return nil
        }
//
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//            print(view as? MKMapItem)
//            print(view as? MKMarkerAnnotationView)
//            print(view as? MKPinAnnotationView)
//            print(view as? MKPointAnnotation)
//            print(view as? MKUserLocationView)
//            view.detailCalloutAccessoryView = UIImageView(image: UIImage(systemName: "figure.walk"))
        }
        
//        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//                if annotation.isEqual(mapView.userLocation) {
//                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
//                annotationView.image = UIImage(named: "geo")
//                return annotationView
//            }
//        }
        
        func makeUIView(context: Context) -> Representable {
            self
        }
        
        func updateUIView(_: Representable, context: Context) { }
    }
}
