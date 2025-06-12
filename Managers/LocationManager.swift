//
//  LocationManager.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        print("定位成功：\(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失敗：\(error.localizedDescription)")
    }
}

extension CLLocationCoordinate2D: Identifiable, Equatable {
    public var id: String { "\(latitude),\(longitude)" }
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
