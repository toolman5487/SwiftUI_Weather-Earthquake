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
                    areaIntensity: "2級",
                    eqStation: []
                )
            ]
        )
    )
    
    static let mockList: [Earthquake] = [
        .mock,
        Earthquake(
            earthquakeNo: 100000,
            reportType: "地震速報",
            reportContent: "另一筆假資料內容",
            reportColor: "黃色",
            reportImageURI: nil,
            web: nil,
            shakemapImageURI: nil,
            earthquakeInfo: EarthquakeInfo(
                originTime: "2025-06-12 15:30",
                source: "中央氣象署",
                focalDepth: 20,
                epicenter: Epicenter(
                    location: "高雄市前鎮區",
                    epicenterLatitude: 22.60,
                    epicenterLongitude: 120.31
                ),
                earthquakeMagnitude: EarthquakeMagnitude(
                    magnitudeType: "芮氏規模",
                    magnitudeValue: 4.8
                )
            ),
            intensity: Intensity(
                shakingArea: [
                    ShakingArea(
                        areaDesc: "高雄市地區",
                        countyName: "高雄市",
                        areaIntensity: "2級",
                        eqStation: []
                    )
                ]
            )
        ),
        Earthquake(
            earthquakeNo: 100002,
            reportType: "地震速報",
            reportContent: "新竹外海發生有感地震，請注意安全",
            reportColor: "紅色",
            reportImageURI: nil,
            web: nil,
            shakemapImageURI: nil,
            earthquakeInfo: EarthquakeInfo(
                originTime: "2025-06-14 18:22",
                source: "中央氣象署",
                focalDepth: 15,
                epicenter: Epicenter(
                    location: "新竹縣外海",
                    epicenterLatitude: 24.89,
                    epicenterLongitude: 120.85
                ),
                earthquakeMagnitude: EarthquakeMagnitude(
                    magnitudeType: "芮氏規模",
                    magnitudeValue: 5.3
                )
            ),
            intensity: Intensity(
                shakingArea: [
                    ShakingArea(
                        areaDesc: "新竹縣地區",
                        countyName: "新竹縣",
                        areaIntensity: "2級",
                        eqStation: []
                    )
                ]
            )
        ),
        Earthquake(
            earthquakeNo: 100003,
            reportType: "地震報告",
            reportContent: "花蓮縣近海發生地震，最大震度4級",
            reportColor: "黃色",
            reportImageURI: nil,
            web: nil,
            shakemapImageURI: nil,
            earthquakeInfo: EarthquakeInfo(
                originTime: "2025-06-15 07:50",
                source: "中央氣象署",
                focalDepth: 23,
                epicenter: Epicenter(
                    location: "花蓮縣近海",
                    epicenterLatitude: 23.98,
                    epicenterLongitude: 121.61
                ),
                earthquakeMagnitude: EarthquakeMagnitude(
                    magnitudeType: "芮氏規模",
                    magnitudeValue: 4.6
                )
            ),
            intensity: Intensity(
                shakingArea: [
                    ShakingArea(
                        areaDesc: "花蓮縣地區",
                        countyName: "花蓮縣",
                        areaIntensity: "2級",
                        eqStation: []
                    )
                ]
            )
        ),
        Earthquake(
            earthquakeNo: 100001,
            reportType: "地震報告",
            reportContent: "第三筆假資料，台北有感",
            reportColor: "橙色",
            reportImageURI: nil,
            web: nil,
            shakemapImageURI: nil,
            earthquakeInfo: EarthquakeInfo(
                originTime: "2025-06-13 09:15",
                source: "中央氣象署",
                focalDepth: 7,
                epicenter: Epicenter(
                    location: "台北市大安區",
                    epicenterLatitude: 25.03,
                    epicenterLongitude: 121.54
                ),
                earthquakeMagnitude: EarthquakeMagnitude(
                    magnitudeType: "芮氏規模",
                    magnitudeValue: 3.6
                )
            ),
            intensity: Intensity(
                shakingArea: [
                    ShakingArea(
                        areaDesc: "台北市地區",
                        countyName: "台北市",
                        areaIntensity: "2級",
                        eqStation: []
                    )
                ]
            )
        )
    ]
}
