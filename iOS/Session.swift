import Foundation
import Hero

final class Sesssion: ObservableObject {
    @Published var loading = true
    @Published var walking = UInt32()
    @Published var chart = Chart.zero
}
