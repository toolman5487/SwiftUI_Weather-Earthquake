//
//  EarthquakeModel.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import Foundation

struct EarthquakeData: Codable {
    let success: String
    let result: ResultInfo
    let records: Records
}

struct ResultInfo: Codable {
    let resourceID: String

    enum CodingKeys: String, CodingKey {
        case resourceID = "resource_id"
    }
}

struct Records: Codable {
    let datasetDescription: String
    let earthquake: [Earthquake]

    enum CodingKeys: String, CodingKey {
        case datasetDescription
        case earthquake = "Earthquake"
    }
}

struct Earthquake: Identifiable, Codable {
    let earthquakeNo: Int
    let reportType: String
    let reportContent: String
    let reportColor: String
    let reportImageURI: String?
    let web: String?
    let shakemapImageURI: String?
    let earthquakeInfo: EarthquakeInfo
    let intensity: Intensity

    var id: Int { earthquakeNo }

    enum CodingKeys: String, CodingKey {
        case earthquakeNo = "EarthquakeNo"
        case reportType = "ReportType"
        case reportContent = "ReportContent"
        case reportColor = "ReportColor"
        case reportImageURI = "ReportImageURI"
        case web = "Web"
        case shakemapImageURI = "ShakemapImageURI"
        case earthquakeInfo = "EarthquakeInfo"
        case intensity = "Intensity"
    }
}

struct EarthquakeInfo: Codable {
    let originTime: String
    let source: String
    let focalDepth: Double
    let epicenter: Epicenter
    let earthquakeMagnitude: EarthquakeMagnitude

    enum CodingKeys: String, CodingKey {
        case originTime = "OriginTime"
        case source = "Source"
        case focalDepth = "FocalDepth"
        case epicenter = "Epicenter"
        case earthquakeMagnitude = "EarthquakeMagnitude"
    }
}

struct Epicenter: Codable {
    let location: String
    let epicenterLatitude: Double
    let epicenterLongitude: Double

    enum CodingKeys: String, CodingKey {
        case location = "Location"
        case epicenterLatitude = "EpicenterLatitude"
        case epicenterLongitude = "EpicenterLongitude"
    }
}

struct EarthquakeMagnitude: Codable {
    let magnitudeType: String
    let magnitudeValue: Double

    enum CodingKeys: String, CodingKey {
        case magnitudeType = "MagnitudeType"
        case magnitudeValue = "MagnitudeValue"
    }
}

struct Intensity: Codable {
    let shakingArea: [ShakingArea]

    enum CodingKeys: String, CodingKey {
        case shakingArea = "ShakingArea"
    }
}

struct ShakingArea: Codable {
    let areaDesc: String
    let countyName: String
    let areaIntensity: String
    let eqStation: [EqStation]

    enum CodingKeys: String, CodingKey {
        case areaDesc = "AreaDesc"
        case countyName = "CountyName"
        case areaIntensity = "AreaIntensity"
        case eqStation = "EqStation"
    }
}

struct EqStation: Codable {
    let stationName: String
    let stationID: String
    let seismicIntensity: String

    enum CodingKeys: String, CodingKey {
        case stationName = "StationName"
        case stationID = "StationID"
        case seismicIntensity = "SeismicIntensity"
    }
}

extension Earthquake {
    static let mock = Earthquake(
        earthquakeNo: 99999,
        reportType: "地震報告",
        reportContent: "這是範例內容",
        reportColor: "紅色",
        reportImageURI: nil,
        web: nil,
        shakemapImageURI: nil,
        earthquakeInfo: EarthquakeInfo(
            originTime: "2025-06-12 11:02",
            source: "中央氣象署",
            focalDepth: 10,
            epicenter: Epicenter(
                location: "台中市西區",
                epicenterLatitude: 24.15,
                epicenterLongitude: 120.67
            ),
            earthquakeMagnitude: EarthquakeMagnitude(
                magnitudeType: "芮氏規模",
                magnitudeValue: 2.0
            )
        ),
        intensity: Intensity(
            shakingArea: [
                ShakingArea(
                    areaDesc: "台中市地區",
                    countyName: "台中市",
                    areaIntensity: "二級",
                    eqStation: []
                )
            ]
        )
    )
}
