import SwiftUI
import MapKit

final class Map: MKMapView, UIViewRepresentable, ObservableObject, MKMapViewDelegate {
    private var centred = 0
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        isRotateEnabled = false
        isPitchEnabled = false
        showsUserLocation = true
        pointOfInterestFilter = .excludingAll
        showsTraffic = false
        mapType = .mutedStandard
        delegate = self
        setUserTrackingMode(.follow, animated: false)
    }
    
    func center() {
        setUserTrackingMode(.follow, animated: true)
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
    
    func makeUIView(context: Context) -> Map {
        self
    }
    
    func updateUIView(_: Map, context: Context) { }
}
