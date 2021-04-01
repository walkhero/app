import MapKit
import Hero

extension Map {
    final class Tiler: MKTileOverlay {
        var renderer: MKTileOverlayRenderer!
        private var tiles: [Int : Set<Tile>]
        private let queue = DispatchQueue(label: "", qos: .utility)
        private let dark = UIImage(named: "dark")!.pngData()!
        
        init(tiles: Set<Tile>) {
            self.tiles = [Constants.map.zoom : tiles]
            super.init(urlTemplate: nil)
            tileSize = .init(width: 512, height: 512)
            renderer = .init(tileOverlay: self)
        }
        
        func add(_ tiles: Set<Tile>) {
            queue.async { [weak self] in
                guard let self = self else { return }
                self.tiles = self.tiles.keys.reduce(into: self.tiles) {
                    $0[$1] = .init(.init($0[$1]!) + Array($1 == Constants.map.zoom ? tiles : tiles.with(zoom: $1)))
                }
                DispatchQueue.main.async { [weak self] in
                    self?.renderer.reloadData()
                }
            }
        }
        
        override func loadTile(at: MKTileOverlayPath, result: @escaping(Data?, Error?) -> Void) {
            queue.async { [weak self] in
                guard let self = self else { return }
                if self.tiles[at.z] == nil {
                    self.tiles[at.z] = self.tiles[Constants.map.zoom]!.with(zoom: at.z)
                }
                
                if self.tiles[at.z]!.contains(where: {
                    $0.x == at.x && $0.y == at.y
                }) {
                    result(nil, nil)
                } else {
                    result(self.dark, nil)
                }
            }
        }
    }
}
