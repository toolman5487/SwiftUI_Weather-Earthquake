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

class EarthquakeService: EarthquakeServiceProtocol {
    func fetchEarthquakes() -> AnyPublisher<[Earthquake], Error> {
        let apiKey = Bundle.main.infoDictionary?["CWBApiKey"] as? String ?? ""
        let urlString = "https://opendata.cwa.gov.tw/api/v1/rest/datastore/E-A0015-001?Authorization=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                do {
                    let decoded = try JSONDecoder().decode(EarthquakeData.self, from: data)
                    return decoded.records.earthquake
                } catch {
                    print("Error：\(error)")
                    throw error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
