import MapKit
import Combine
import Hero

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        private var subs = Set<AnyCancellable>()
        
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
            
//            let tiler = Tiler(tiles: wrapper.tiles)
//            addOverlay(tiler, level: .aboveRoads)
            
            overla
            addOverlay(MKPolygon(points: [.init(x: 0, y: 0),
                                          .init(x: MKMapSize.world.width / 2, y: 0),
                                          .init(x: MKMapSize.world.width / 2, y: MKMapSize.world.height),
                                          .init(x: 0, y: MKMapSize.world.height)], count: 4, interiorPolygons:
                                            wrapper.tiles.map {
                                                MKPolygon(points: [
                                                                            MKMapPoint(
                                                                                x: .init($0.x) * Constants.map.tile,
                                                                                y: .init($0.y) * Constants.map.tile),
                                                                            MKMapPoint(
                                                                                x: .init($0.x + 1) * Constants.map.tile,
                                                                                y: .init($0.y) * Constants.map.tile),
                                                                            MKMapPoint(
                                                                                x: .init($0.x + 1) * Constants.map.tile,
                                                                                y: .init($0.y + 1) * Constants.map.tile),
                                                            MKMapPoint(
                                                                x: .init($0.x) * Constants.map.tile,
                                                                y: .init($0.y + 1) * Constants.map.tile)], count: 4)
                                            }))
            
//            MKPolygon(
            
//            wrapper.tiles.forEach {
//                addOverlay(MKPolygon(points: [
//                                            MKMapPoint(
//                                                x: .init($0.x) * Constants.map.tile,
//                                                y: .init($0.y) * Constants.map.tile),
//                                            MKMapPoint(
//                                                x: .init($0.x + 1) * Constants.map.tile,
//                                                y: .init($0.y) * Constants.map.tile),
//                                            MKMapPoint(
//                                                x: .init($0.x + 1) * Constants.map.tile,
//                                                y: .init($0.y + 1) * Constants.map.tile)], count: 3))
//            }
//
            wrapper.add?
                .debounce(for: .seconds(3), scheduler: DispatchQueue.global(qos: .utility))
                .removeDuplicates()
                .sink { [weak self] all in
//                    tiler.add($0)
                    
                    
                    fatalError()
                    
                }.store(in: &subs)
            
//            addOverlay(MKPolygon(coordinates: <#T##UnsafePointer<CLLocationCoordinate2D>#>, count: <#T##Int#>))
            
            var region = MKCoordinateRegion()
            region.center = userLocation.location == nil ? centerCoordinate : userLocation.coordinate
            region.span = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            setRegion(region, animated: false)
        }
        
//        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
//            (rendererFor as! Tiler).renderer
//        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let a = MKPolygonRenderer(overlay: overlay)
            a.fillColor = .init(white: 0, alpha: 0.5)
            return a
        }
    }
}
