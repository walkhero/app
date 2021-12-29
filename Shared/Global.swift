import Archivable
import Hero

let cloud = Cloud<Archive>.new(identifier: "iCloud.WalkHero")
let game = Game()
let location = Location()

#if os(iOS)
let store = Store()
#endif
