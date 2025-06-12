//
//  EarthquakeModel.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import Foundation

struct EarthquakeData: Codable {
    let success: String
    let result: Result
    let records: Records
}

// MARK: - Records
struct Records: Codable {
    let datasetDescription: String
    let earthquake: [Earthquake]

    enum CodingKeys: String, CodingKey {
        case datasetDescription
        case earthquake = "Earthquake"
    }
}

// MARK: - Earthquake
struct Earthquake: Codable {
    let earthquakeNo: Int
    let reportType, reportColor, reportContent: String
    let reportImageURI: String
    let reportRemark: String
    let web: String
    let shakemapImageURI: String
    let earthquakeInfo: EarthquakeInfo
    let intensity: Intensity

    enum CodingKeys: String, CodingKey {
        case earthquakeNo = "EarthquakeNo"
        case reportType = "ReportType"
        case reportColor = "ReportColor"
        case reportContent = "ReportContent"
        case reportImageURI = "ReportImageURI"
        case reportRemark = "ReportRemark"
        case web = "Web"
        case shakemapImageURI = "ShakemapImageURI"
        case earthquakeInfo = "EarthquakeInfo"
        case intensity = "Intensity"
    }
}

// MARK: - EarthquakeInfo
struct EarthquakeInfo: Codable {
    let originTime, source: String
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

// MARK: - EarthquakeMagnitude
struct EarthquakeMagnitude: Codable {
    let magnitudeType: String
    let magnitudeValue: Int

    enum CodingKeys: String, CodingKey {
        case magnitudeType = "MagnitudeType"
        case magnitudeValue = "MagnitudeValue"
    }
}

// MARK: - Epicenter
struct Epicenter: Codable {
    let location: String
    let epicenterLatitude, epicenterLongitude: Double

    enum CodingKeys: String, CodingKey {
        case location = "Location"
        case epicenterLatitude = "EpicenterLatitude"
        case epicenterLongitude = "EpicenterLongitude"
    }
}

// MARK: - Intensity
struct Intensity: Codable {
    let shakingArea: [ShakingArea]

    enum CodingKeys: String, CodingKey {
        case shakingArea = "ShakingArea"
    }
}

// MARK: - ShakingArea
struct ShakingArea: Codable {
    let areaDesc, countyName: String
    let infoStatus: InfoStatus?
    let areaIntensity: AreaIntensityEnum
    let eqStation: [EqStation]

    enum CodingKeys: String, CodingKey {
        case areaDesc = "AreaDesc"
        case countyName = "CountyName"
        case infoStatus = "InfoStatus"
        case areaIntensity = "AreaIntensity"
        case eqStation = "EqStation"
    }
}

enum AreaIntensityEnum: String, Codable {
    case the1級 = "1級"
    case the2級 = "2級"
    case the3級 = "3級"
    case the4級 = "4級"
}

// MARK: - EqStation
struct EqStation: Codable {
    let pga, pgv: PGA?
    let stationName, stationID: String
    let infoStatus: InfoStatus?
    let backAzimuth, epicenterDistance: Double
    let seismicIntensity: AreaIntensityEnum
    let stationLatitude, stationLongitude: Double
    let waveImageURI: String?

    enum CodingKeys: String, CodingKey {
        case pga, pgv
        case stationName = "StationName"
        case stationID = "StationID"
        case infoStatus = "InfoStatus"
        case backAzimuth = "BackAzimuth"
        case epicenterDistance = "EpicenterDistance"
        case seismicIntensity = "SeismicIntensity"
        case stationLatitude = "StationLatitude"
        case stationLongitude = "StationLongitude"
        case waveImageURI = "WaveImageURI"
    }
}

enum InfoStatus: String, Codable {
    case observe = "observe"
}

// MARK: - PGA
struct PGA: Codable {
    let unit: Unit
    let ewComponent, nsComponent, vComponent, intScaleValue: Double

    enum CodingKeys: String, CodingKey {
        case unit
        case ewComponent = "EWComponent"
        case nsComponent = "NSComponent"
        case vComponent = "VComponent"
        case intScaleValue = "IntScaleValue"
    }
}

enum Unit: String, Codable {
    case gal = "gal"
    case kine = "kine"
}

// MARK: - Result
struct Result: Codable {
    let resourceID: String
    let fields: [Field]

    enum CodingKeys: String, CodingKey {
        case resourceID = "resource_id"
        case fields
    }
}

// MARK: - Field
struct Field: Codable {
    let id: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case float = "Float"
    case integer = "Integer"
    case string = "String"
    case timestamp = "Timestamp"
}

