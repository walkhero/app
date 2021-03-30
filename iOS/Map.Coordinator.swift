import MapKit
import Combine
import Hero

extension Map {
    final class Coordinator: MKMapView, MKMapViewDelegate {
        private var subs = Set<AnyCancellable>()
        private let dark = UIImage(named: "dark")!.pngData()!
        
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
            
            wrapper.tiles.sink { [weak self] in
                guard let self = self else { return }
                self.removeOverlays(self.overlays)
                self.addOverlay(Tiler(tiles: $0, dark: self.dark), level: .aboveLabels)
                print("tiles \($0.count)")
            }.store(in: &subs)
            
            var region = MKCoordinateRegion()
            region.center = userLocation.location == nil ? centerCoordinate : userLocation.coordinate
            region.span = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            setRegion(region, animated: false)
        }
        
        func mapView(_: MKMapView, regionDidChangeAnimated: Bool) {
            print("zoom: \(Int(round(log2(360 * Double(frame.width) / 256 / region.span.longitudeDelta))))")
        }
        
        func mapView(_: MKMapView, rendererFor: MKOverlay) -> MKOverlayRenderer {
            MKTileOverlayRenderer(tileOverlay: rendererFor as! Tiler)
        }
    }
}

final class Tiler: MKTileOverlay {
    private var tiles = [Int : Set<Tile>]()
    private let dark: Data
    
    init(tiles: Set<Tile>, dark: Data) {
        self.tiles = [20 : tiles]
        self.dark = dark
        super.init(urlTemplate: nil)
        tileSize = .init(width: 512, height: 512)
    }
    
    override func loadTile(at: MKTileOverlayPath, result: @escaping(Data?, Error?) -> Void) {
        if tiles[at.z] == nil {
            tiles[at.z] = tiles[20]!.with(zoom: at.z)
            print("add zoom \(at.z)")
        }
        
        if tiles[at.z]!.contains(where: {
            $0.x == at.x && $0.y == at.y
        }) {
            result(nil, nil)
        } else {
            result(dark, nil)
        }
    }
}

