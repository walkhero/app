import Archivable
import Hero
import CloudKit

let cloud = Cloud<Archive, CKContainer>.new(identifier: "iCloud.WalkHero")

#if os(iOS)
var store = Store()
#endif
