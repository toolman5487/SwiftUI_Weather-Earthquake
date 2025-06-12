//
//  EarthquakeService.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import Foundation
import Combine

protocol EarthquakeServiceProtocol {
    func fetchEarthquakes() -> AnyPublisher<[Earthquake], Error>
}

class EarthquakeService:EarthquakeServiceProtocol {
    
    func fetchEarthquakes() -> AnyPublisher<[Earthquake], Error> {
        let apiKey = Bundle.main.infoDictionary?["CWBApiKey"] as? String ?? ""
        let urlString = "https://opendata.cwa.gov.tw/api/v1/rest/datastore/E-A0015-001?Authorization=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EarthquakeData.self, decoder: JSONDecoder())
            .map { $0.records.earthquake }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
