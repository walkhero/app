import Archivable
import Hero

let cloud = Cloud<Archive>.new(identifier: "iCloud.WalkHero")
let game = Game()

#if os(iOS)
let store = Store()
#endif
