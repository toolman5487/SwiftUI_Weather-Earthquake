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
    @Published var cityName: String?
    
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
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first, error == nil {
                DispatchQueue.main.async {
                    self.cityName = placemark.administrativeArea ?? placemark.locality ?? placemark.subAdministrativeArea ?? "未知地點"
                    print("取得地名：\(self.cityName ?? "未知")")
                }
            } else {
                print("反地理編碼失敗：\(error?.localizedDescription ?? "未知錯誤")")
            }
        }
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
