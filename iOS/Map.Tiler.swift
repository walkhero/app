import MapKit
import Hero

extension Map {
    final class Tiler: MKTileOverlay {
        private var tiles = [Int : Set<Tile>]()
        private let dark: Data
        
        init(tiles: Set<Tile>, dark: Data) {
            self.tiles = [Constants.map.zoom : tiles]
            self.dark = dark
            super.init(urlTemplate: nil)
            tileSize = .init(width: 512, height: 512)
        }
        
        override func loadTile(at: MKTileOverlayPath, result: @escaping(Data?, Error?) -> Void) {
            if tiles[at.z] == nil {
                tiles[at.z] = tiles[Constants.map.zoom]!.with(zoom: at.z)
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
}
