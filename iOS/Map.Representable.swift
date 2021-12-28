import SwiftUI
import MapKit

extension Map {
    final class Representable: MKMapView, MKMapViewDelegate, UIViewRepresentable {
        private var previous = CLLocationCoordinate2D()
        private var centred = false
        private var follow = true
        
        required init?(coder: NSCoder) { nil }
        init() {
            super.init(frame: .zero)
            isRotateEnabled = false
            isPitchEnabled = false
            showsUserLocation = true
            mapType = .standard
            delegate = self
            setUserTrackingMode(.follow, animated: false)
            
//            tiles
//                .throttle(for: .seconds(1), scheduler: dispatch, latest: true)
//                .removeDuplicates()
//                .map(\.overlay)
//                .receive(on: DispatchQueue.main)
//                .sink { [weak self] in
//                    if let overlays = self?.overlays {
//                        self?.removeOverlays(overlays)
//                    }
//                    self?.addOverlay($0, level: .aboveLabels)
//                }
//                .store(in: &subs)
//
//            addOverlay(Set<Tile>().overlay)
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
            } else if follow,
                      abs(coordinate.latitude - previous.latitude)
                        + abs(coordinate.longitude - previous.longitude)
                        > 0.0007 {
                setCenter(coordinate, animated: true)
            }
            previous = coordinate
        }
        
        func makeUIView(context: Context) -> Representable {
            self
        }
        
        func updateUIView(_: Representable, context: Context) { }
    }
}


/*
 final class Coordinator: MKMapView, MKMapViewDelegate {
     var follow = true {
         didSet {
             if follow && !oldValue {
                 previous = .init()
             }
         }
     }
     
     let tiles = PassthroughSubject<Set<Tile>, Never>()
     private var previous = CLLocationCoordinate2D()
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
         
         tiles
             .throttle(for: .seconds(1), scheduler: dispatch, latest: true)
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
         renderer.fillColor = .init(white: 0, alpha: UIApplication.dark ? 0.75 : 0.45)
         return renderer
     }
     
     func mapView(_: MKMapView, didUpdate: MKUserLocation) {
         guard let coordinate = didUpdate.location?.coordinate else { return }
         if !centred {
             centred = true
             setCamera(.init(lookingAtCenter: coordinate, fromDistance: 500, pitch: 0, heading: 0), animated: false)
         } else if follow,
                   abs(coordinate.latitude - previous.latitude) + abs(coordinate.longitude - previous.longitude) > 0.0007 {
             setCenter(coordinate, animated: true)
         }
         previous = coordinate
     }
 }
 */
