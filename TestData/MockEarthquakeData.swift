//
//  MockEarthquakeData.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/15.
//

import Foundation

struct MockEarthquakeData {
    static let mockEarthquake = Earthquake(
        earthquakeNo: 123456,
        reportType: "地震報告",
        reportContent: "模擬有感地震測試",
        reportColor: "綠色",
        reportImageURI: nil,
        web: nil,
        shakemapImageURI: nil,
        earthquakeInfo: EarthquakeInfo(
            originTime: "2025-06-15 18:00:00",
            source: "模擬資料",
            focalDepth: 10,
            epicenter: Epicenter(location: "臺北市中心", epicenterLatitude: 25.03, epicenterLongitude: 121.56),
            earthquakeMagnitude: EarthquakeMagnitude(magnitudeType: "芮氏規模", magnitudeValue: 5.5)
        ),
        intensity: Intensity(shakingArea: [
            ShakingArea(areaDesc: "臺北市", countyName: "臺北市", areaIntensity: "4級", eqStation: [])
        ])
    )
}
