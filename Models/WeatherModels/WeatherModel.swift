//
//  WeatherModel.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/13.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let success: String
    let result: Result
    let records: WeatherRecords
}

// MARK: - WeatherRecords
struct WeatherRecords: Codable {
    let datasetDescription: String
    let location: [Location]

    enum CodingKeys: String, CodingKey {
        case datasetDescription = "datasetDescription"
        case location
    }
}

// MARK: - Location
struct Location: Codable {
    let locationName: String
    let weatherElement: [WeatherElement]

    enum CodingKeys: String, CodingKey {
        case locationName = "locationName"
        case weatherElement
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let elementName: String
    let time: [Time]

    enum CodingKeys: String, CodingKey {
        case elementName = "elementName"
        case time
    }
}

// MARK: - Time
struct Time: Codable {
    let startTime: String
    let endTime: String
    let parameter: Parameter

    enum CodingKeys: String, CodingKey {
        case startTime = "startTime"
        case endTime = "endTime"
        case parameter
    }

    // MARK: - Parameter
    struct Parameter: Codable {
        let parameterName: String
        let parameterValue: String?
        let parameterUnit: String?

        enum CodingKeys: String, CodingKey {
            case parameterName = "parameterName"
            case parameterValue = "parameterValue"
            case parameterUnit = "parameterUnit"
        }
    }
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
    let id, type: String
}
