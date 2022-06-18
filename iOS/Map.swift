import SwiftUI
import MapKit

private let limit = CLLocationDistance(1000)

final class Map: MKMapView, UIViewRepresentable, ObservableObject, MKMapViewDelegate {
    private var centred = 0
    
    required init?(coder: NSCoder) { nil }
    init() {
        print("map")
        super.init(frame: .zero)
        isRotateEnabled = false
        isPitchEnabled = false
        showsUserLocation = true
        pointOfInterestFilter = .excludingAll
        showsTraffic = false
        mapType = .standard
        delegate = self
        setCameraZoomRange(.init(maxCenterCoordinateDistance: limit), animated: false)
        setUserTrackingMode(.follow, animated: false)
    }
    
    deinit {
        print("map gone")
    }
    
    func center() {
        setUserTrackingMode(.follow, animated: true)
        setCameraZoomRange(.init(maxCenterCoordinateDistance: limit), animated: true)
    }
    
    func update(overlay: MKPolygon) {
        removeOverlays(overlays)
        addOverlay(overlay, level: .aboveLabels)
    }
    
    func mapViewDidFinishLoadingMap(_: MKMapView) {
        guard centred < 2 else { return }
        centred += 1
        setUserTrackingMode(.follow, animated: false)
    }
    
    func mapView(_: MKMapView, didUpdate: MKUserLocation) {
        guard centred < 2 else { return }
        centred += 1
        setUserTrackingMode(.follow, animated: false)
    }
    
    func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: rendererFor)
        renderer.fillColor = .init(named: "Tile")
        return renderer
    }
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        guard cameraZoomRange.maxCenterCoordinateDistance == limit else { return }
        setCameraZoomRange(.init(maxCenterCoordinateDistance: 6000), animated: true)
    }
    
    func makeUIView(context: Context) -> Map {
        self
    }
    
    func updateUIView(_: Map, context: Context) { }
}


/*
 private weak var status: Status!
 //        private var first = true
 //        private var subs = Set<AnyCancellable>()
 //        private let dispatch = DispatchQueue(label: "", qos: .utility)
 //
 //        required init?(coder: NSCoder) { nil }
 //        init(status: Status) {
 //            self.status = status
 //            super.init(frame: .zero)
 //            isRotateEnabled = false
 //            isPitchEnabled = false
 //            showsUserLocation = true
 //            pointOfInterestFilter = .excludingAll
 //            mapType = .standard
 //            delegate = self
 //
 //            cloud
 //                .map(\.tiles)
 //                .first()
 //                .merge(with: cloud
 //                        .map(\.tiles)
 //                        .combineLatest(status.$squares) { $0.union($1.items) }
 //                        .throttle(for: .seconds(3), scheduler: dispatch, latest: true))
 //                .removeDuplicates()
 //                .map(\.overlay)
 //                .receive(on: DispatchQueue.main)
 //                .combineLatest(status.$hide)
 //                .sink { [weak self] overlay, hide in
 //                    if let overlays = self?.overlays {
 //                        self?.removeOverlays(overlays)
 //                    }
 //                    if hide {
 //                        self?.addOverlay(overlay, level: .aboveLabels)
 //                    }
 //                }
 //                .store(in: &subs)
 //
 //            status
 //                .$follow
 //                .dropFirst()
 //                .sink { [weak self] in
 //                    self?.setUserTrackingMode($0 ? .follow : .none, animated: true)
 //                }
 //                .store(in: &subs)
 //        }
 //
 //        func mapView(_: MKMapView, didUpdate: MKUserLocation) {
 //            guard first else { return }
 //            first = false
 //            setUserTrackingMode(.follow, animated: true)
 //        }
 //
 //        func mapView(_: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
 //            status.follow = mode == .follow
 //        }
 //
 //        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
 //            let renderer = MKPolygonRenderer(overlay: rendererFor)
 //            renderer.fillColor = .init(named: "Tile")
 //            return renderer
 //        }
 */
