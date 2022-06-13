import CloudKit
import Archivable
import Hero

let cloud = Cloud<Archive, CKContainer>.new(identifier: "iCloud.WalkHero")

#if os(iOS)
let store = Store()
#endif
