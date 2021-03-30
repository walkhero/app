import MapKit
import Hero

extension Map {
    final class Tiler: MKTileOverlay {
        private var tiles = [Int : Set<Tile>]()
        private let dark: Data
        private let queue = DispatchQueue(label: "", qos: .utility)
        
        init(tiles: Set<Tile>, dark: Data) {
            self.tiles = [Constants.map.zoom : tiles]
            self.dark = dark
            super.init(urlTemplate: nil)
            tileSize = .init(width: 512, height: 512)
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
