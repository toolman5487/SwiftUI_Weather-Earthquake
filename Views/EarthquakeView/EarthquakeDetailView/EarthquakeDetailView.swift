//
//  EarthquakeDetailView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI
import MapKit

struct EarthquakeDetailView: View {
    
    let earthquake: Earthquake
    @State private var mapRegion: MKCoordinateRegion
    
    struct EpicenterAnnotation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }
    var epicenterAnnotation: [EpicenterAnnotation] {
        [EpicenterAnnotation(coordinate: epicenterCoordinate)]
    }
    
    var epicenterCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: earthquake.earthquakeInfo.epicenter.epicenterLatitude ?? 0,
            longitude: earthquake.earthquakeInfo.epicenter.epicenterLongitude ?? 0
        )
    }
    
    init(earthquake: Earthquake) {
        self.earthquake = earthquake
        let coord = CLLocationCoordinate2D(
            latitude: earthquake.earthquakeInfo.epicenter.epicenterLatitude ?? 0,
            longitude: earthquake.earthquakeInfo.epicenter.epicenterLongitude ?? 0
        )
        _mapRegion = State(initialValue: MKCoordinateRegion(
            center: coord,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }
    
    
    var body: some View {
        List {
            Section(header: Text("地震基本資訊")) {
                InfoRow(
                    title: "發生時間",
                    value: earthquake.earthquakeInfo.originTime)
                InfoRow(
                    title: "地點",
                    value: earthquake.earthquakeInfo.epicenter.location)
                InfoRow(
                    title: "規模",
                    value: String(format: "%.1f",earthquake.earthquakeInfo.earthquakeMagnitude.magnitudeValue)
                )
                InfoRow(
                    title: "深度",
                    value: String(format: "%.1f 公里", earthquake.earthquakeInfo.focalDepth ?? 0)
                )
                InfoRow(title: "震央座標",
                        value: "\(earthquake.earthquakeInfo.epicenter.epicenterLatitude ?? 0), \(earthquake.earthquakeInfo.epicenter.epicenterLongitude ?? 0)")
            }
            
            Section(header: Text("各地震度分布")) {
                ForEach(earthquake.intensity.shakingArea, id: \.areaDesc) { area in
                    InfoRow(title: area.areaDesc, value: area.areaIntensity)
                }
            }
            
            Section(header: Text("震央位置圖")) {
                Map(coordinateRegion: $mapRegion, annotationItems: epicenterAnnotation) { item in
                    MapMarker(coordinate: item.coordinate, tint: .red)
                }
                .frame(width:.infinity ,height: 300)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("地震詳情")
    }
}

#Preview {
    EarthquakeDetailView(earthquake: Earthquake.mock)
}
