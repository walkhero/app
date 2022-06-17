import SwiftUI
import MapKit

final class Map: MKMapView, UIViewRepresentable, ObservableObject {
    required init?(coder: NSCoder) { nil }
    init() {
        print("map")
        super.init(frame: .zero)
        isPitchEnabled = false
        showsUserLocation = true
        showsTraffic = false
        userTrackingMode = .none
    }
    
    deinit {
        print("map gone")
    }
    
    func makeUIView(context: Context) -> Map {
        self
    }
    
    func updateUIView(_: Map, context: Context) { }
}
