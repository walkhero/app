import Archivable
import Hero

let cloud = Cloud<Archive>.new(identifier: "iCloud.WalkHero")

#if os(iOS)
let store = Store()
#endif
